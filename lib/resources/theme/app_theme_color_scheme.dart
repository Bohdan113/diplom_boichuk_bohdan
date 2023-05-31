import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class AppThemeColorScheme extends ColorScheme {
  // ignore: library_private_types_in_public_api
  static _LightColorScheme light = _LightColorScheme();

  // ignore: library_private_types_in_public_api
  static _DarkColorScheme dark = _DarkColorScheme();

  final Color blue;
  final Color white;
  final Color black;
  final Color red;
  final Color secondBlack;
  final Color veryLightPink;
  final Color grey;
  final Color secondGrey;
  final Color greyDark;
  final Color greyLight;
  final Color yellow;
  final Color errorColor;
  final Color primaryGreen, secondGreen;
  final Color percentIndicatorBackground;
  final Color underlineColor;
  final Color dividerColor;
  final Color greenDark;
  final Color backButtonColor;
  final Color chatTextFieldColor;
  final Color backgroundColor;
  final Color messageUserColor, userMessageCreatedColor, otherMessageCreateColor;
  final Color titleGreyColor;

  @override
  // ignore: overridden_fields
  final Brightness brightness;

  const AppThemeColorScheme({
    required this.brightness,
    required this.blue,
    required this.white,
    required this.black,
    required this.grey,
    required this.veryLightPink,
    required this.errorColor,
    required this.primaryGreen,
    required this.secondGrey,
    required this.underlineColor,
    required this.greyDark,
    required this.greyLight,
    required this.dividerColor,
    required this.greenDark,
    required this.backButtonColor,
    required this.chatTextFieldColor,
    required this.backgroundColor,
    required this.messageUserColor,
    required this.percentIndicatorBackground,
    required this.userMessageCreatedColor,
    required this.otherMessageCreateColor,
    required this.secondBlack,
    required this.yellow,
    required this.red,
    required this.titleGreyColor,
    required this.secondGreen,
  }) : super(
          brightness: brightness,
          primary: blue,
          // ignore: deprecated_member_use
          primaryVariant: Colors.black,
          secondary: Colors.black,
          // ignore: deprecated_member_use
          secondaryVariant: Colors.black,
          surface: Colors.black,
          background: Colors.black,
          error: Colors.black,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          onBackground: black,
          onError: Colors.black,
        );
}

class _DarkColorScheme extends AppThemeColorScheme {
  _DarkColorScheme()
      : super(
          brightness: Brightness.dark,
          blue: HexColor('#00FFFF'),
          white: HexColor('#ffffff'),
          black: HexColor('#000000'),
          grey: HexColor('#999999'),
          veryLightPink: HexColor('#dddddd'),
          errorColor: HexColor('#FF7676'),
          primaryGreen: HexColor('#4B8E4B'),
          underlineColor: HexColor('#CFCFCF'),
          greyDark: HexColor('#808080'),
          greyLight: HexColor('#DAE2DD'),
          dividerColor: HexColor('#D9D9D9'),
          greenDark: HexColor('#206A3E'),
          backButtonColor: HexColor('#81AF93'),
          chatTextFieldColor: HexColor('#EAEAEA'),
          backgroundColor: HexColor('#F2F7F2'),
          messageUserColor: HexColor('#C9DCC9'),
          userMessageCreatedColor: HexColor('#4E6958'),
          otherMessageCreateColor: HexColor('#243D24'),
          percentIndicatorBackground: HexColor('#D3EBD3'),
          secondGrey: HexColor('#BCBCBC'),
          secondBlack: HexColor('#333333'),
          yellow: HexColor('#F4B511'),
          red: HexColor('#A40000'),
          titleGreyColor: HexColor('#9C9C9C'),
          secondGreen: HexColor('#C9DBC9'),
        );
}

class _LightColorScheme extends AppThemeColorScheme {
  _LightColorScheme()
      : super(
          brightness: Brightness.light,
          blue: HexColor('#00FFFF'),
          white: HexColor('#ffffff'),
          black: HexColor('#000000'),
          grey: HexColor('#999999'),
          veryLightPink: HexColor('#dddddd'),
          errorColor: HexColor('#FF7676'),
          primaryGreen: HexColor('#4B8E4B'),
          underlineColor: HexColor('#CFCFCF'),
          greyDark: HexColor('#808080'),
          greyLight: HexColor('#DAE2DD'),
          dividerColor: HexColor('#D9D9D9'),
          greenDark: HexColor('#206A3E'),
          backButtonColor: HexColor('#81AF93'),
          chatTextFieldColor: HexColor('#EAEAEA'),
          backgroundColor: HexColor('#F2F7F2'),
          userMessageCreatedColor: HexColor('#4E6958'),
          otherMessageCreateColor: HexColor('#243D24'),
          messageUserColor: HexColor('#C9DCC9'),
          percentIndicatorBackground: HexColor('#D3EBD3'),
          secondGrey: HexColor('#BCBCBC'),
          secondBlack: HexColor('#333333'),
          yellow: HexColor('#F4B511'),
          red: HexColor('#A40000'),
          titleGreyColor: HexColor('#9C9C9C'),
          secondGreen: HexColor('#C9DBC9'),
        );
}
