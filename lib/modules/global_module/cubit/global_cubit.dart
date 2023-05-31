import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_data.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_model.dart';
import 'package:diplom_boichuk_bohdan/resources/hive/hive_resources.dart';
import 'package:diplom_boichuk_bohdan/utils/navigate_mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart' as song;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> with NavigateMixin {
  GlobalCubit() : super(GlobalInitialState()) {
    initData();
  }

  RecorderController recorderController = RecorderController();
  song.FlutterSoundRecorder soundRecorder = song.FlutterSoundRecorder();
  var flutterSoundPlayer = song.FlutterSoundPlayer();
  TextEditingController nameController = TextEditingController();
  PlayerController playerController = PlayerController();

  List<AudioModel> listData = [];
  Box<AudioData> getData = Hive.box<AudioData>(HiveResources.audioData);
  String recordPath = '';
  DateTime dateCreate = DateTime.now();

  initData() async {
    listData = getData.get(0)?.data ?? [];
    listData.sort((a, b) => b.createAudio!.compareTo(a.createAudio!));
    emitInitialState();
  }

  void initialRecord() async {
    dir = Platform.isAndroid ? await getTemporaryDirectory() : await getApplicationDocumentsDirectory();
    var date = DateTime.now();
    dateCreate = DateTime.now();
    recordPath = '${dir?.path}/NewRecord-${date.year}-${date.month}-${date.day}-${date.hour}-${date.minute}-${date.second}.mp3';
  }

  void pauseRecording() {
    recorderController.pause();
  }

  void resumeRecord() {
    recorderController.reset();
  }

  void disposeRecord() {
    recorderController.dispose();
  }

  bool starRecord = false;

  void startRecord() async {
    await _audioSession();
    if (Platform.isIOS) {
      if (starRecord == false) {
        await soundRecorder.openRecorder().then((e) async {
          await soundRecorder.startRecorder(
            toFile: 'NewRecord-${dateCreate.year}-${dateCreate.month}-${dateCreate.day}-${dateCreate.hour}-${dateCreate.minute}-${dateCreate.second}.aac',
          );
          await soundRecorder.setSubscriptionDuration(const Duration(milliseconds: 100));
          return 'ok';
        });
      } else if (soundRecorder.isRecording) {
        await soundRecorder.pauseRecorder();
      } else {
        await soundRecorder.resumeRecorder();
      }
    } else if (recorderController.isRecording == false) {
      await recorderController.checkPermission();
      await recorderController.record(path: recordPath);
    } else {
      await recorderController.pause();
    }
    starRecord = true;
    emitInitialState();
  }

  Future<void> _audioSession() async {
    final session = await AudioSession.instance;
    await session.configure(
      AudioSessionConfiguration(
        avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
        avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth | AVAudioSessionCategoryOptions.defaultToSpeaker,
        avAudioSessionMode: AVAudioSessionMode.spokenAudio,
        avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
        avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
        androidAudioAttributes: const AndroidAudioAttributes(
          contentType: AndroidAudioContentType.speech,
          flags: AndroidAudioFlags.none,
          usage: AndroidAudioUsage.voiceCommunication,
        ),
        androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ),
    );

  }

  Directory? dir;

  void saveRecord() async {
    if (Platform.isIOS) {
      recordPath = await soundRecorder.stopRecorder() ?? '';
    } else {
      await recorderController.stop();
    }
    _removeListener();
    emitInitialState();
    playerController.preparePlayer(path: recordPath);
    nameController.text = recordPath.replaceAll('${dir?.path}/', '').split('tmp/').last.replaceAll('.mp3', '');
    navigatePop();
    emitInitialState();
  }

  void initRecord() async {
    if (playerController.playerState == PlayerState.playing) await playerController.pausePlayer();
    emitInitialState();
    if (Platform.isIOS) {
      soundRecorder = song.FlutterSoundRecorder();
    } else {
      recorderController = RecorderController()
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 16000;
    }
    starRecord = false;
    emitInitialState();
  }

  int tempIndex = 0;

  void playInList({String? path, int index = 0}) async {
    if (flutterSoundPlayer.isOpen() == false) {
      await flutterSoundPlayer.openPlayer();
    }
    if (tempIndex != index && listData[tempIndex].isPlay == true) {
      listData[tempIndex].isPlay = false;
      await flutterSoundPlayer.pausePlayer();
      await flutterSoundPlayer.startPlayer(fromDataBuffer: File(path ?? '').readAsBytesSync());
      listData[index].isPlay = true;
    } else if (flutterSoundPlayer.isPlaying) {
      listData[index].isPlay = false;
      await flutterSoundPlayer.pausePlayer();
    } else {
      listData[index].isPlay = true;
      await flutterSoundPlayer.startPlayer(fromDataBuffer: File(path ?? '').readAsBytesSync());
    }
    tempIndex = index;
    emitInitialState();
  }

  void play() async {
    if (playerController.playerState == PlayerState.playing) {
      await playerController.pausePlayer();
    } else {
      await playerController.startPlayer(finishMode: FinishMode.pause, forceRefresh: true);
    }
    emitInitialState();
  }

  Future<void> _removeListener() async {
    if (playerController.hasListeners) {
      playerController.removeListener(() {});
      playerController = PlayerController();
    }
    playerController = PlayerController()..addListener(() {});
  }

  void saveAudio() async {
    late File newFile;
    if (pickFile == null) {
      var uni = (await File(recordPath).create()).readAsBytesSync();
      newFile = await File(recordPath).writeAsBytes(uni);
    } else {
      newFile = await File(recordPath).writeAsBytes(pickFile!.readAsBytesSync());
    }
    var audio = AudioModel(
      path: newFile.path,
      title: nameController.text,
      createAudio: dateCreate,
      maxTime: playerController.maxDuration,
    );
    listData.add(audio);
    listData.sort((a, b) => b.createAudio!.compareTo(a.createAudio!));
    navigatePop();
    await getData.put(0, AudioData(data: listData));
    emitInitialState();
  }

  void clearNewData() {
    // ignore: invalid_use_of_protected_member
    if (playerController.hasListeners) {
      playerController.removeListener(() {});
    }
    playerController = PlayerController();
    recorderController = RecorderController();
    soundRecorder = song.FlutterSoundRecorder();
    emitInitialState();
  }

  emitInitialState() => emit(GlobalInitialState());

  File? pickFile;

  void pickAudioFile() async {
    if (playerController.playerState == PlayerState.playing) await playerController.pausePlayer();
    emitInitialState();
    var platform = FilePicker.platform;
    var file = await platform.pickFiles(initialDirectory: (await getDownloadsDirectory())?.path, allowMultiple: false);
    if (file != null) {
      var path = file.files.first.path ?? '';
      pickFile = File(path);
      await _removeListener();
      playerController.preparePlayer(path: path);
      nameController.text = file.files.first.name;
      emitInitialState();
    }
  }
}
