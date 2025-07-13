import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';

import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../../widgets/app_widgets/app_text_field/rules.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  GlobalKey<AppTextFormFieldState> oldPasswordState = GlobalKey();
  GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<AppTextFormFieldState> confirmPasswordState = GlobalKey();

  @override
  void dispose() {
    super.dispose();

    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'change_password'.tr,
        showBackButton: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 46.0,
          horizontal: 18.0,
        ),
        child: AppButton(
          onPressed: () {
            if (passwordController.text != confirmPasswordController.text) {
              confirmPasswordState.currentState?.shake();
              confirmPasswordState.currentState?.addApiError(
                'confirm_password_does_not_match'.tr,
              );
              return;
            }
          },
          text: 'change_password'.tr,
        ),
      ),
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            70.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'old_password'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                key: oldPasswordState,
                controller: oldPasswordController,
                hintText: 'enter_password'.tr,
                appFieldType: AppFieldType.password,
                textInputAction: TextInputAction.next,
                rules: AppTextFieldRules.passwordRules,
                alwaysShowRules: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'password'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                key: passwordState,
                controller: passwordController,
                hintText: 'enter_password'.tr,
                appFieldType: AppFieldType.password,
                textInputAction: TextInputAction.next,
                rules: AppTextFieldRules.passwordRules,
                alwaysShowRules: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 're_inter_password'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                key: confirmPasswordState,
                controller: confirmPasswordController,
                hintText: 're_inter_password_hint'.tr,
                appFieldType: AppFieldType.password,
                textInputAction: TextInputAction.done,
                alwaysShowRules: false,
                checkRulesOnTyping: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
