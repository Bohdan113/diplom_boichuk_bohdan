import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/theme/app_theme.dart';
import '../text_widget/custom_text.dart';

class PrimaryButton extends StatefulWidget {
  final String titleButton;
  final bool isActive;
  final Function() onPressed;
  final bool isLoading;
  final double? heightButton, borderRadius, fontSize;
  final Color? backgroundColor, textColor;
  final BorderSide? borderSide;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const PrimaryButton(
      {Key? key,
      required this.titleButton,
      this.isActive = false,
      required this.onPressed,
      this.isLoading = false,
      this.heightButton,
      this.borderRadius,
      this.backgroundColor,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.borderSide,
      this.textAlign})
      : super(key: key);

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(duration: const Duration(milliseconds: 750), vsync: this);
    animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return SizedBox(
      width: 1.sw,
      height: widget.heightButton ?? 50.sp,
      child: ElevatedButton(
        onPressed: widget.isLoading
            ? null
            : widget.isActive
                ? widget.onPressed
                : null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor ?? colors.primaryGreen.withOpacity(widget.isActive ? 1 : 0.5)),
          elevation: MaterialStateProperty.all(0),
          overlayColor: MaterialStateProperty.all(
            colors.black.withOpacity(0.1),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.sp),
              side: widget.borderSide ?? BorderSide.none,
            ),
          ),
        ),
        child: widget.isLoading
            ? SizedBox(
                width: 30.sp,
                height: 30.sp,
                child: CircularProgressIndicator(
                  strokeWidth: 2.2,
                  valueColor: animationController.drive(
                    ColorTween(
                      begin: colors.white,
                      end: colors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: widget.textAlign == TextAlign.start ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: widget.titleButton,
                      color: widget.textColor ?? colors.white,
                      fontWeight: widget.fontWeight ?? FontWeight.w500,
                      size: widget.fontSize ?? 20.sp),
                ],
              ),
      ),
    );
  }
}
