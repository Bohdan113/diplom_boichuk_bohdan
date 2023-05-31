import 'dart:io';

import 'package:dash_flags/dash_flags.dart';
import 'package:diplom_boichuk_bohdan/common/widgets/button/primary_button.dart';
import 'package:diplom_boichuk_bohdan/common/widgets/text_widget/custom_text.dart';
import 'package:diplom_boichuk_bohdan/main.dart';
import 'package:diplom_boichuk_bohdan/modules/app_routes.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/cubit/global_cubit.dart';
import 'package:diplom_boichuk_bohdan/modules/global_module/model/audio_data.dart';
import 'package:diplom_boichuk_bohdan/resources/assets/icons_svg_assets.dart';
import 'package:diplom_boichuk_bohdan/resources/theme/app_theme.dart';
import 'package:diplom_boichuk_bohdan/resources/theme/app_theme_color_scheme.dart';
import 'package:diplom_boichuk_bohdan/utils/navigate_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:google_fonts/google_fonts.dart';

part 'widgets/record_dialog.dart';

class ReviewAllDataScreen extends StatelessWidget with NavigateMixin {
  const ReviewAllDataScreen({Key? key}) : super(key: key);

  GlobalCubit get globalCubit => Modular.get<GlobalCubit>();

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return BlocConsumer<GlobalCubit, GlobalState>(
      bloc: globalCubit,
      builder: (context, state) => _buildScaffold(colors, context),
      listener: (context, state) {},
    );
  }

  Scaffold _buildScaffold(AppThemeColorScheme colors, BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        toolbarHeight: 50.h,
        leadingWidth: 60.w,
        leading: Row(
          children: [
            SizedBox(width: 30.w),
            Card(
              color: Colors.transparent,
              margin: EdgeInsets.zero,
              elevation: 3,
              shadowColor: colors.black.withOpacity(0.4),
              child: LanguageFlag(
                language: Language.fromCode('uk'),
                height: 20.h,
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              globalCubit.clearNewData();
              navigatePush(AppRoutes.addNewAudio);
            },
            customBorder: const CircleBorder(),
            child: Container(
              width: 35.sp,
              height: 35.sp,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Center(
                child: Icon(CupertinoIcons.add, color: colors.black, size: 25.sp),
              ),
            ),
          ),
          SizedBox(width: 30.w),
        ],
        title: Center(child: SvgPicture.asset(IconsSvgAssets.icAudioBoichukSave, width: 0.55.sw)),
      ),
      body: AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        duration: const Duration(milliseconds: 350),
        switchInCurve: Curves.fastOutSlowIn,
        switchOutCurve: Curves.fastOutSlowIn,
        child: globalCubit.listData.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Add your first music',
                      size: 25.sp,
                    ),
                    Icon(
                      CupertinoIcons.music_note_list,
                      size: 50.sp,
                    ),
                  ],
                ),
              )
            : ListView.separated(
                padding: EdgeInsets.only(top: 10.h),
                itemCount: globalCubit.listData.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  var item = globalCubit.listData[index];
                  return Slidable(
                    key: const ValueKey(0),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            globalCubit.listData.removeAt(index);
                            await globalCubit.getData.put(0, AudioData(data: globalCubit.listData));
                            globalCubit.emitInitialState();
                          },
                          backgroundColor: colors.red,
                          borderRadius: BorderRadius.horizontal(left: Radius.circular(20.sp)),
                          icon: Icons.delete,
                          label: 'DELETE',
                        ),
                      ],
                    ),
                    child: Container(
                      width: 1.sw,
                      height: 100,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(color: colors.primaryGreen.withOpacity(0.3), borderRadius: BorderRadius.circular(20.sp)),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 23.w, vertical: 5.h),
                            child: InkWell(
                              onTap: () {
                                globalCubit.playInList(path: item.path, index: index);
                              },
                              customBorder: const CircleBorder(),
                              child: Padding(
                                padding: EdgeInsets.all(5.sp),
                                child: Icon(
                                  item.isPlay ? CupertinoIcons.pause : CupertinoIcons.play,
                                  size: 25.sp,
                                ),
                              ),
                            ),
                          ),
                          StreamBuilder<int>(
                            stream: globalCubit.playerController.onCurrentDurationChanged,
                            builder: (context, snapshot) {
                              if (snapshot.data == globalCubit.playerController.maxDuration && item.maxTime == globalCubit.playerController.maxDuration) {
                                globalCubit.listData[globalCubit.tempIndex].isPlay = false;
                                globalCubit.emitInitialState();
                              }
                              return Container();
                            },
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(text: item.title ?? 'Non Title'),
                                CustomText(
                                    text:
                                        '${DateTime(0, 0, 0, 0, 0, 0, item.maxTime ?? 0).minute} min ${DateTime(0, 0, 0, 0, 0, 0, item.maxTime ?? 0).second} sec '),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
