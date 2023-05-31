part of '../review_all_data_screen.dart';

class RecordDialog extends StatefulWidget with NavigateMixin {
  const RecordDialog({Key? key}) : super(key: key);

  @override
  State<RecordDialog> createState() => _RecordDialogState();
}

class _RecordDialogState extends State<RecordDialog> with WidgetsBindingObserver {
  late GlobalCubit cubit;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    cubit = Modular.get<GlobalCubit>();
    cubit.initRecord();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      return;
    }
    if (state == AppLifecycleState.paused) {
      cubit.pauseRecording();
    } else if (state == AppLifecycleState.resumed) {
      //TODO if need in future added resume record.
      cubit.resumeRecord();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    cubit.disposeRecord();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return BlocConsumer<GlobalCubit, GlobalState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          return _buildBoxRecord(colors, state);
        });
  }

  Widget _buildBoxRecord(AppThemeColorScheme colors, GlobalState state) {
    // final hours =
    //     '${cubit.durationStream.inHours.toString().length < 2 ? '0${cubit.durationStream.inHours}' : cubit.durationStream.inHours.remainder(99)}';
    // final minutes =
    //     '${cubit.durationStream.inMinutes.remainder(60).toString().length < 2 ? '0${cubit.durationStream.inMinutes}' : cubit.durationStream.inMinutes.remainder(60)}';
    // final second =
    //     '${cubit.durationStream.inSeconds.remainder(60).toString().length < 2 ? '0${cubit.durationStream.inSeconds.remainder(60)}' : cubit.durationStream.inSeconds.remainder(60)}';
    return Container(
      height: 0.8.sh,
      decoration: BoxDecoration(color: colors.white, borderRadius: BorderRadius.circular(25.sp)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 1.sw, height: 33.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: PrimaryButton(
              titleButton: '${(Platform.isIOS ? cubit.soundRecorder.isRecording : cubit.recorderController.isRecording) ? 'Pause' : 'Start'} Record',
              isActive: true,
              onPressed: () {
                cubit.startRecord();
              },
            ),
          ),
          if (Platform.isAndroid)
            AudioWaveforms(
              size: Size(1.sw, 80.h),
              recorderController: cubit.recorderController,
              enableGesture: true,
              waveStyle: WaveStyle(
                backgroundColor: Colors.black,
                waveColor: Colors.black,
                durationLinesColor: Colors.black,
                durationStyle: GoogleFonts.londrinaSolid(fontSize: 14.sp, fontWeight: FontWeight.w300, color: colors.red),
                showDurationLabel: true,
                spacing: 10,
                durationTextPadding: 10,
                scaleFactor: 60,
                extendWaveform: false,
                showMiddleLine: false,
              ),
            ),
          if (Platform.isAndroid) SizedBox(height: 50.h),
          if (Platform.isIOS)
            SizedBox(
              height: 60.h,
              width: 1.sw,
              child: Center(
                child: StreamBuilder<RecordingDisposition>(
                  stream: cubit.soundRecorder.onProgress,
                  builder: (context, snapshot) {
                    return CustomText(
                      text: '${snapshot.data?.duration.inMinutes ?? 0} min ${snapshot.data?.duration.inSeconds ?? 0} sec',
                      color: colors.black,
                    );
                  },
                ),
              ),
            ),
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            layoutBuilder: (currentChild, previousChildren) {
              return currentChild ?? previousChildren.first;
            },
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: Container(),
          ),
          if (cubit.starRecord)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: PrimaryButton(
                titleButton: 'Save Record',
                isActive: true,
                onPressed: () {
                  cubit.saveRecord();
                },
              ),
            ),

        ],
      ),
    );
  }
}
