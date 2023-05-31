import 'package:diplom_boichuk_bohdan/resources/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastGlobalView extends StatefulWidget {
  final String message;
  final double radiusBorder;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const ToastGlobalView(
      {Key? key, this.radiusBorder = 6, required this.message, this.backgroundColor, this.textStyle, this.textAlign})
      : super(key: key);

  @override
  State<ToastGlobalView> createState() => _ToastGlobalViewState();
}

class _ToastGlobalViewState extends State<ToastGlobalView> with TickerProviderStateMixin {

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return Column(
      children: [
        SizedBox(
          height: 72.h,
        ),
        Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? colors.primaryGreen,
            borderRadius: BorderRadius.circular(widget.radiusBorder),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 17.w),
                child: Text(
                  widget.message,
                  style: widget.textStyle ?? GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500, color: colors.white),
                  maxLines: 3,
                  textAlign: widget.textAlign ?? TextAlign.center,
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ],
    );
  }
}
