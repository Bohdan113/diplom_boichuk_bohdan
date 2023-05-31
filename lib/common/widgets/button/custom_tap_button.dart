import 'package:diplom_boichuk_bohdan/resources/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTabButton extends StatelessWidget {
  final double? width;
  final double? radius,height;
  final Widget child;
  final Widget? insideSplashWidget;
  final Function()? onTap, plusButtonTap;
  final bool withButtonPlus;
  final bool isAddedInOrderPlace;
  final Color? selectedButton, unSelectedButton;

  const CustomTabButton({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.radius,
    this.withButtonPlus = false,
    this.isAddedInOrderPlace = false,
    this.onTap,
    this.plusButtonTap,
    this.selectedButton,
    this.unSelectedButton, this.insideSplashWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        child,
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap ?? () {},
            borderRadius: BorderRadius.circular(radius ?? 8.sp),
            child: Container(
              width: width,
              height: height,
              color: Colors.transparent,
              child: insideSplashWidget,
            ),
          ),
        ),
        if (withButtonPlus)
          Padding(
            padding: EdgeInsets.all(12.sp),
            child: Stack(
              children: [
                Container(
                  width: 32.sp,
                  height: 32.sp,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius ?? 8.sp),
                      color: isAddedInOrderPlace ? unSelectedButton ?? Colors.transparent : selectedButton ?? colors.primaryGreen,
                      border: Border.all(color: selectedButton??colors.primaryGreen)),
                  child: Center(
                    child: SvgPicture.asset(
                      isAddedInOrderPlace ? "IconsSvgAssets.icCheckDone" : 'IconsSvgAssets.icAdd',
                      color: isAddedInOrderPlace ? selectedButton : (unSelectedButton),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: plusButtonTap ?? () {},
                    borderRadius: BorderRadius.circular(radius ?? 8.sp),
                    child: SizedBox(
                      width: 32.sp,
                      height: 32.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
