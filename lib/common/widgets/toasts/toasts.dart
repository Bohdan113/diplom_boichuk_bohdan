import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'toast_global_view.dart';

///if [graviti] not null, [positionedTop], [positionedRight], [positionedLeft],[positionedBottom] is ignoring,
///if all this = null, will be show on top:50.sp, left/right: 16.sp
class ShowToastUtil {
  final BuildContext buildContext;
  TextStyle? textStyle;
  double radiusBorder;
  Color? backgroundColor;
  ToastGravity? graviti;
  double? positionedTop;
  double? positionedRight;
  double? positionedLeft;
  double? positionedBottom;
  Duration duration;
  TextAlign? textAlign;
  late FToast fToast;

  static const Duration _defaultDuration = Duration(seconds: 3);

  ShowToastUtil({
    required this.buildContext,
    this.backgroundColor,
    this.radiusBorder = 6,
    this.textStyle,
    this.graviti,
    this.positionedTop,
    this.positionedBottom,
    this.positionedLeft,
    this.positionedRight,
    this.duration = _defaultDuration,
    this.textAlign,
  }) {
    fToast = FToast();
    fToast.init(buildContext);
  }

  showToast({
    required String message,
    Color? backgroundColor,
    double radiusBorder = 6,
    Widget? child,
    TextStyle? textStyle,
  }) {
    deactivate();
    if (graviti == null) {
      fToast.showToast(
          child: child ??
              ToastGlobalView(
                message: message,
                backgroundColor: backgroundColor,
                radiusBorder: radiusBorder,
                textStyle: textStyle,
              ),
          toastDuration: duration,
          positionedToastBuilder: (context, child) {
            return Positioned(
              top: positionedTop ?? 0.h,
              left: positionedLeft ?? 40.w,
              right: positionedRight ?? 40.w,
              bottom: positionedBottom,
              child: child,
            );
          });
    } else {
      fToast.showToast(
        child: child ??
            ToastGlobalView(
              message: message,
              backgroundColor: backgroundColor,
              radiusBorder: radiusBorder,
              textStyle: textStyle,
            ),
        toastDuration: duration,
      );
    }
  }

  deactivate() {
    fToast.removeCustomToast();
  }
}
