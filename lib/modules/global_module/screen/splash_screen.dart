import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:diplom_boichuk_bohdan/modules/app_routes.dart';
import 'package:diplom_boichuk_bohdan/utils/navigate_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../resources/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigateMixin {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((value) => navigateReplaceAll(AppRoutes.review));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.of(context).colors;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoActivityIndicator(
              radius: 50.sp,
            ),
            SizedBox(
              height: 200.h,
              child: AnimatedTextKit(
                animatedTexts: [
                  ScaleAnimatedText(
                    ' AUDIO BOICHUK SAVE Project'.toUpperCase(),
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.londrinaSolid(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.sp,
                      color: colors.black,
                    ),
                    duration: const Duration(seconds: 4,milliseconds: 500)
                  ),
                ],
                totalRepeatCount: 10,
                pause: const Duration(seconds: 3),
                displayFullTextOnTap: true,
                stopPauseOnTap: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
