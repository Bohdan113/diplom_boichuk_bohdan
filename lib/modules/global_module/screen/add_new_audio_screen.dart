import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:diplom_boichuk_bohdan/common/widgets/button/primary_button.dart';
import 'package:diplom_boichuk_bohdan/main.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/cubit/global_cubit.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/screen/review_all_data_screen.dart';
import 'package:diplom_boichuk_bohdan/resources/assets/icons_svg_assets.dart';
import 'package:diplom_boichuk_bohdan/resources/theme/app_theme.dart';
import 'package:diplom_boichuk_bohdan/resources/theme/app_theme_color_scheme.dart';
import 'package:diplom_boichuk_bohdan/utils/navigate_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNewAudioScreen extends StatefulWidget {
  const AddNewAudioScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAudioScreen> createState() => _AddNewAudioScreenState();
}

class _AddNewAudioScreenState extends State<AddNewAudioScreen> with NavigateMixin {
  GlobalCubit get cubit => Modular.get<GlobalCubit>();

  @override
  void initState() {
    cubit.initialRecord();
    super.initState();
  }

  @override
  void dispose() {
    if (cubit.playerController.playerState == PlayerState.playing) {
      cubit.playerController.stopPlayer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return BlocConsumer<GlobalCubit, GlobalState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (context, state) {
          return _buildScaffold(colors, context);
        });
  }

  Scaffold _buildScaffold(AppThemeColorScheme colors, BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Row(
          children: [
            SizedBox(width: 15.w),
            InkWell(
              onTap: () {
                navigatePop();
              },
              customBorder: const CircleBorder(),
              child: Container(
                width: 35.sp,
                height: 35.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Center(
                  child: Icon(CupertinoIcons.back, color: colors.black, size: 25.sp),
                ),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {},
            customBorder: const CircleBorder(),
            child: Container(
              width: 35.sp,
              height: 35.sp,
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
          ),
          SizedBox(width: 30.w),
        ],
        title: Center(child: SvgPicture.asset(IconsSvgAssets.icAudioBoichukSave, width: 0.55.sw)),
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
            child: PrimaryButton(
              titleButton: 'Pick audio File',
              isActive: true,
              onPressed: () {
                cubit.pickAudioFile();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
            child: PrimaryButton(
              titleButton: 'Record',
              isActive: true,
              onPressed: () {
                cubit.initialRecord();
                showModalBottomSheet(context: context, builder: (context) => const RecordDialog());
              },
            ),
          ),
          SizedBox(height: 10.h),
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
            // ignore: invalid_use_of_protected_member
            child: cubit.playerController.hasListeners == true
                ? Column(
                    children: [
                      SizedBox(height: 10.h),
                      AudioFileWaveforms(
                        size: Size(1.sw, 60.h),
                        playerController: cubit.playerController,
                        enableSeekGesture: true,
                        continuousWaveform: true,
                        animationCurve: Curves.fastOutSlowIn,
                        playerWaveStyle: const PlayerWaveStyle(
                          fixedWaveColor: Colors.grey,
                          liveWaveColor: Colors.black,
                          seekLineColor: Colors.red,
                          showSeekLine: true,
                          spacing: 10,
                          waveThickness: 4.2,
                          scaleFactor: 500,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
                        child: InkWell(
                          onTap: () {
                            cubit.play();
                          },
                          customBorder: const CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(5.sp),
                            child: Icon(
                              cubit.playerController.playerState == PlayerState.playing ? CupertinoIcons.pause : CupertinoIcons.play,
                              size: 25.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(horizontal: 23.w),
                        child: TextField(
                          controller: cubit.nameController,
                          style: GoogleFonts.londrinaSolid(fontSize: 20.sp, color: colors.black),
                          maxLines: 2,
                          minLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Name audio:',
                            labelStyle: GoogleFonts.roboto(
                              color: colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
                        child: PrimaryButton(
                          titleButton: 'Save audio',
                          isActive: true,
                          onPressed: () {
                            cubit.saveAudio();
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
