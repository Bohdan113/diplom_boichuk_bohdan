import 'package:easy_localization/easy_localization.dart';
import 'package:phone_number/phone_number.dart';

import '../../resources/app_strings.dart';

class Validator {
  static final Validator _instance = Validator._privateConstructor();

  Validator._privateConstructor();

  factory Validator() {
    return _instance;
  }

  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp numberAndLettersRegExp = RegExp('[A-Z0-9]');

  static final RegExp nameRegExp = RegExp(
    "[A-Za-z]",
  );

  static final RegExp nickNameRegExp = RegExp(
    "[A-Za-z0-9!@\$#%&'*+-/=?^_`(){|}~:;\"]",
  );

  /// 1. Amount can start with 'zero' if it's decimal
  /// 2. If it starts with 'zero' there is only one zero character is possible to input
  /// 3. Amount can't start with 'zero' in any other other cases
  /// 4. Amount integer part isn't restricted with length
  /// 5. Decimal separators can be entered are '.' and ','
  /// 6. Decimal part consists of maximum 2 characters
  static bool matchAmountPattern(String amount, {int decimalPartLength = 2}) {
    return RegExp(r'^(([1-9]{1}[0-9]*)|0{1})([.,][0-9]{0,' + decimalPartLength.toString() + r'})?$').hasMatch(amount);
  }

  static bool matchAmount(String amount) {
    return RegExp(r'^\d{0,18}(?:\.\d{0,2})?$').hasMatch(amount);
  }

  bool hasSpecialChars(String password) {
    return RegExp("['!#\$%&\"()*+,-./:;<=>?@\\[\\]^_{|}~\\\\]").hasMatch(password);
  }

  ///return true if text has lowercase chars
  bool hasLowerCaseChars(String password) {
    return RegExp(r'[a-z]').hasMatch(password);
  }

  ///return true if text has uppercase chars
  bool hasUpperCaseChars(String password) {
    return RegExp(r'[A-Z]').hasMatch(password);
  }

  bool hasNumbers(String password) {
    return RegExp(r'[0-9]').hasMatch(password);
  }

  bool hasSpecialCharsWithoutHyphens(String title) {
    return RegExp("['!#\$%&\"()*+,./:;<=>?@\\[\\]^_{|}~\\\\]").hasMatch(title);
  }

  Future<String?> checkPhoneNumber(String? number) async {
    String? errorText;
    bool isValidNumber = false;
    if (number == null || number.isEmpty || number.length <= 4) {
      errorText = AppStrings.youEnteredTheWrongNumber.tr();
    } else if (number.length < 6) {
      errorText = AppStrings.youEnteredTheWrongNumber.tr();
    } else {
      errorText = null;
    }
    if (errorText == null) {
      try {
        isValidNumber = await PhoneNumberUtil().validate(number!);
        if (isValidNumber == false) {
          errorText = AppStrings.youEnteredTheWrongNumber.tr();
        }
      } catch (e) {
        errorText = AppStrings.youEnteredTheWrongNumber.tr();
      }
    }
    return errorText;
  }

  String mapServerErrorMessageToUser({required String serverErrorMessage, required String errorTextMessage}) {
    if (serverErrorMessage.startsWith("text")) {
      //TODO: message
    }
    return errorTextMessage;
  }
}
