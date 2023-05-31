import 'dart:ui' as ui show Shadow, FontFeature;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme_color_scheme.dart';

class AppTextTheme extends TextTheme {
  final AppThemeTextStyle semiBold64;
  final AppThemeTextStyle semiBold34;
  final AppThemeTextStyle semiBold32;
  final AppThemeTextStyle semiBold24;
  final AppThemeTextStyle semiBold18;
  final AppThemeTextStyle semiBold16;
  final AppThemeTextStyle regular24;
  final AppThemeTextStyle regular18;
  final AppThemeTextStyle regular16;
  final AppThemeTextStyle regular15;
  final AppThemeTextStyle regular14;
  final AppThemeTextStyle regular12;
  final AppThemeTextStyle linkRegular14;
  final AppThemeTextStyle textStyleWelcomeScreen;

  const AppTextTheme({
    required this.textStyleWelcomeScreen,
    required this.semiBold64,
    required this.semiBold34,
    required this.semiBold32,
    required this.semiBold24,
    required this.semiBold18,
    required this.semiBold16,
    required this.regular24,
    required this.regular18,
    required this.regular16,
    required this.regular15,
    required this.regular14,
    required this.regular12,
    required this.linkRegular14,
  }) : super();

  factory AppTextTheme.byColorScheme(
    AppThemeColorScheme colorScheme,
  ) =>
      AppTextTheme(
        semiBold64: AppThemeTextStyle(
          colorScheme,
          fontSize: 64.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w600,
          fontFamily: GoogleFonts.roboto().fontFamily,
          height: 1.171,
        ),
        semiBold34: AppThemeTextStyle(
          colorScheme,
          fontSize: 34.sp,
          color: colorScheme.white,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: GoogleFonts.roboto(fontWeight: FontWeight.bold).fontWeight,
          height: 1.1875,
        ),
        semiBold32: AppThemeTextStyle(
          colorScheme,
          fontSize: 32.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
          height: 1.1875,
        ),
        semiBold24: AppThemeTextStyle(
          colorScheme,
          fontSize: 24.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
          height: 1.166,
        ),
        semiBold18: AppThemeTextStyle(
          colorScheme,
          fontSize: 18.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
          height: 1.33,
        ),
        semiBold16: AppThemeTextStyle(
          colorScheme,
          fontSize: 16.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w600,
          height: 1.25,
        ),
        regular24: AppThemeTextStyle(
          colorScheme,
          fontSize: 24.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.166,
        ),
        regular18: AppThemeTextStyle(
          colorScheme,
          fontSize: 18.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.25,
        ),
        regular16: AppThemeTextStyle(
          colorScheme,
          fontSize: 16.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.25,
        ),
        regular15: AppThemeTextStyle(
          colorScheme,
          fontSize: 15.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.25,
        ),
        regular14: AppThemeTextStyle(
          colorScheme,
          fontSize: 14.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.142,
        ),
        regular12: AppThemeTextStyle(
          colorScheme,
          fontSize: 12.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.142,
        ),
        linkRegular14: AppThemeTextStyle(
          colorScheme,
          fontSize: 14.sp,
          color: colorScheme.white,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.w400,
          height: 1.142,
        ),
        textStyleWelcomeScreen: AppThemeTextStyle(
          colorScheme,
          fontSize: 36.sp,
          color: colorScheme.black,
          fontStyle: FontStyle.normal,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: FontWeight.bold,
          height: 1.41.h,
        ),
      );
}

class AppThemeTextStyle extends TextStyle {
  final AppThemeColorScheme colorScheme;

  const AppThemeTextStyle(
    this.colorScheme, {
    bool inherit = true,
    Color? color,
    Color? backgroundColor,
    String? fontFamily,
    List<String>? fontFamilyFallback,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    TextBaseline? textBaseline,
    double? height,
    Locale? locale,
    Paint? foreground,
    Paint? background,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    String? debugLabel,
    List<ui.Shadow>? shadows,
    List<ui.FontFeature>? fontFeatures,
  }) : super(
          inherit: inherit,
          color: color,
          backgroundColor: backgroundColor,
          fontFamily: fontFamily ?? 'Roboto',
          fontFamilyFallback: fontFamilyFallback,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          locale: locale,
          foreground: foreground,
          background: background,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          debugLabel: debugLabel,
          shadows: shadows,
          fontFeatures: fontFeatures,
        );
}
