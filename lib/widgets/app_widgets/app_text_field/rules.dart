import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../../../config/helpers/regex.dart';
import 'app_text_field.dart';
import 'auth_form_rules.dart';

class AppTextFieldRules {
  static validateForm(List<GlobalKey<AppTextFormFieldState>> keys) {
    bool validated = true;
    for (GlobalKey<AppTextFormFieldState> key in keys) {
      validated = key.currentState?.validate(withFocus: false) ?? false;
    }
    return validated;
  }

  static final List<AuthFormRule> emailOrPhoneRules = [
    AuthFormRule(
      ruleText: StorageClient().isAr()
          ? '.البريد الالكتروني أو رقم الهاتف غير صحيح'
          : 'Email address or phone number is not valid.',
      condition: (value) {
        return (isEmail(value) || isPhone(value) && isEgyptianPhone(value));
      },
    ),
  ];

  static final List<AuthFormRule> emailRules = [
    AuthFormRule(
      ruleText: StorageClient().isAr()
          ? 'رجاء ادخال بريد إلكتروني صحيح'
          : 'please enter correct mail format',
      condition: (value) {
        return isEmail(value);
      },
    )
  ];

  static final List<AuthFormRule> phoneNumberRules = [
    AuthFormRule(
      ruleText: StorageClient().isAr()
          ? 'رجاء أدخل رقم هاتف مصري صحيح'
          : 'please enter correct egyptian phone format',
      condition: (value) {
        return isPhone(value) && isEgyptianPhone(value);
      },
    ),
  ];

  static final List<AuthFormRule> passwordRules = [
    AuthFormRule(
      ruleText: 'min_8_char'.tr,
      condition: (value) {
        return value.length >= 8;
      },
    ),
    AuthFormRule(
      ruleText: 'one_lower_letter'.tr,
      condition: (value) {
        return RegExp(r'[a-z]+').hasMatch(value);
      },
    ),
    AuthFormRule(
      ruleText: 'one_upper_letter'.tr,
      condition: (value) {
        return RegExp(r'[A-Z]+').hasMatch(value);
      },
    ),
    AuthFormRule(
      ruleText: "special_char".tr,
      condition: (value) {
        return RegExp(r'(?=[!@#$&%^{}/|])').hasMatch(value);
      },
    ),
    AuthFormRule(
      ruleText: 'one_num'.tr,
      condition: (value) {
        return RegExp(r'(?=[0-9])').hasMatch(value);
      },
    ),
  ];

//   final List<AuthFormRule> idRules = [
//   AuthFormRule(
//     ruleText: 'min_14_char'.tr,
//     condition: (value) {
//       return value.length >= 14;
//     },
//   ),
// ];

// final List<AuthFormRule> nameRules = [
//   AuthFormRule(
//     ruleText: 'invalid_username'.tr,
//     condition: (value) {
//       return GetUtils.isUsername(value);
//     },
//   ),
// ];
}
