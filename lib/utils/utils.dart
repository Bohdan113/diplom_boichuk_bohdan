import 'package:flutter/foundation.dart';

class Utils {
  static void printDebugMode(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}

extension StringExtension on String {
  String toCapitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}