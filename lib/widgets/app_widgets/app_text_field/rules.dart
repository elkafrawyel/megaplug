import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../../../config/clients/storage/storage_client.dart';
import '../../../config/helpers/regex.dart';
import 'auth_form_rules.dart';

final List<AuthFormRule> emailOrPhoneRules = [
  AuthFormRule(
    ruleText: StorageClient().isAr()
        ? '.البريد الالكتروني أو رقم الهاتف غير صحيح'
        : 'Email address or phone number is not valid.',
    condition: (value) {
      return (isEmail(value) || isPhone(value) && isEgyptianPhone(value));
    },
  ),
];

final List<AuthFormRule> emailRules = [
  AuthFormRule(
    ruleText: StorageClient().isAr()
        ? '.البريد الالكتروني غير صحيح'
        : 'Email address is not valid.',
    condition: (value) {
      return GetUtils.isEmail(value);
    },
  )
];

final List<AuthFormRule> phoneNumberRules = [
  AuthFormRule(
    ruleText: StorageClient().isAr()
        ? '.رقم الهاتف غير صحيح'
        : 'Phone number is not valid.',
    condition: (value) {
      return GetUtils.isPhoneNumber(value);
    },
  ),
];
final List<AuthFormRule> passwordRules = [
  AuthFormRule(
    ruleText: 'Minimum 8 characters'.tr,
    condition: (value) {
      return value.length >= 8;
    },
  ),
  AuthFormRule(
    ruleText: 'At least 1 lowercase letter (a-z)'.tr,
    condition: (value) {
      return RegExp(r'(?=[a-z])').hasMatch(value);
    },
  ),
  AuthFormRule(
    ruleText: 'At least 1 uppercase letter (A-Z)'.tr,
    condition: (value) {
      return GetUtils.hasCapitalletter(value);
    },
  ),
  AuthFormRule(
    ruleText: "At least 1 special character (@, #, \$, %, &, *, etc.)".tr,
    condition: (value) {
      return RegExp(r'(?=[!@#$&%^{}/|])').hasMatch(value);
    },
  ),
  AuthFormRule(
    ruleText: 'At least 1 number (0-9)'.tr,
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
