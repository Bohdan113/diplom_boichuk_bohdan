import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_data.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveResources {
  static const audioData = 'audioData';

  Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AudioDataAdapter());
    Hive.registerAdapter(AudioModelAdapter());
    await Hive.openBox<AudioData>(audioData);
  }
}
