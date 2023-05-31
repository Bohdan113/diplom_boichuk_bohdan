import 'package:flutter_screenutil/flutter_screenutil.dart';

class Elevation {
  static Elevation $0dp = Elevation._(0.w);
  static Elevation $1dp = Elevation._(1.w);
  static Elevation $2dp = Elevation._(2.w);
  static Elevation $3dp = Elevation._(3.w);
  static Elevation $4dp = Elevation._(4.w);
  static Elevation $5dp = Elevation._(5.w);
  static Elevation $6dp = Elevation._(6.w);
  static Elevation $8dp = Elevation._(8.w);
  static Elevation $12dp = Elevation._(12.w);
  static Elevation $16dp = Elevation._(16.w);
  static Elevation $24dp = Elevation._(24.w);
  static Elevation $40dp = Elevation._(40.w);

  final double value;

  const Elevation._(this.value);

  @override
  int get hashCode => value.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Elevation && runtimeType == other.runtimeType && value == other.value;

  @override
  String toString() => '$value';
}
