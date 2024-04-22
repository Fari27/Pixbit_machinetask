import 'package:flutter/services.dart';
import 'package:sample/src/constants/string_constants.dart';

class InputValidator {
  static List<TextInputFormatter> userIdValidator({int maxLength = 100}) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9.@]+$')),
    ];
  }

  static String? validatePassword(String value) {
     if (value == (StringConstants.password)) {
      
      return null;
    }
    if (!RegExp(r".*[0-9].*").hasMatch(value)) {
      return 'Password should contain at least one digit (0-9)';
    }
    if (!RegExp(r".*[a-zA-Z].*").hasMatch(value)) {
      return 'Password should contain at least one alphabet (a-z or A-Z)';
    }
    if (!RegExp(r".*[@!?_].*").hasMatch(value)) {
      return 'Password should contain at least one of @, !, ?, or _';
    }
    if (!RegExp(r".{5,}").hasMatch(value)) {
      return 'Password should have a minimum length of 5 characters';
    }
   
    return null;
  }

  static String? validateUsername(String value) {
    //Username bypasing
     if (value == (StringConstants.userName)) {
      
      return null;
    }
    // No spaces
    if (!RegExp(r"^[^\s]+$").hasMatch(value)) {
      return 'Username should not contain spaces';
    }

    // Only numbers (0-9) and characters (a-z, A-Z)
    if (!RegExp(r"^[a-zA-Z@]+$").hasMatch(value)) {
      return 'Username is invalid';
    }
    
   
    return null;
  }

  static List<TextInputFormatter> mobileNumberValidator({int maxLength = 10}) {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      // FilteringTextInputFormatter.deny(RegExp(r'^0+')),
      LengthLimitingTextInputFormatter(maxLength),
    ];
  }

  static List<TextInputFormatter> passwordValidator() {
    return <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9!@#^&*()_;:-]')),
      FilteringTextInputFormatter.deny(InputValidator.denyEmojis),
    ];
  }

  static RegExp denyEmojis = RegExp(
      '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])');
}
