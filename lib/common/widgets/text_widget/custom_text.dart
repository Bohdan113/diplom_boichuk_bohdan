import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/theme/app_theme.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? size, height;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final double? letterSpacing;
  final bool? addUnderline;
  final bool unlimitedLine;

  const CustomText({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
    this.color,
    this.unlimitedLine = false,
    this.maxLines,
    this.textAlign,
    this.letterSpacing,
    this.addUnderline,
    this.height, this.style,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return Text(
      text,
      style: style??GoogleFonts.londrinaSolid(
        color: color ?? colors.black,
        fontSize: size ?? (14.sp),
        fontWeight: fontWeight ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        decoration: addUnderline == true ? TextDecoration.underline : null,
        height: height,
      ),
      maxLines: maxLines ?? (unlimitedLine ? null : 3),
      overflow: unlimitedLine ? null : TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
