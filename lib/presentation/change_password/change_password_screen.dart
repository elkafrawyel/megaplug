import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/repositories/profile_repo.dart';
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

  final TextEditingController confirmPasswordController = TextEditingController();
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
            FocusScope.of(context).unfocus();

            bool validated = AppTextFieldRules.validateForm(
              [
                oldPasswordState,
                passwordState,
                confirmPasswordState,
              ],
            );
            if (passwordController.text != confirmPasswordController.text) {
              confirmPasswordState.currentState?.shake();
              confirmPasswordState.currentState?.addApiError(
                'confirm_password_does_not_match'.tr,
              );
              return;
            }
            if (!validated) {
              return;
            }
            _changePassword();
          },
          text: 'change_password'.tr,
        ),
      ),
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              50.ph,
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
                  // rules: AppTextFieldRules.passwordRules,
                  alwaysShowRules: false,
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
                  onFieldSubmitted: (String value) {
                    if (passwordController.text != confirmPasswordController.text) {
                      confirmPasswordState.currentState?.shake(withFocus: false);
                      confirmPasswordState.currentState?.addApiError(
                        'confirm_password_does_not_match'.tr,
                      );
                      return;
                    }
                  },
                  onFocusLost: () {
                    if (passwordController.text != confirmPasswordController.text) {
                      confirmPasswordState.currentState?.shake(withFocus: false);
                      confirmPasswordState.currentState?.addApiError(
                        'confirm_password_does_not_match'.tr,
                      );
                      return;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changePassword() async {
    oldPasswordState.currentState?.clearApiError();
    passwordState.currentState?.clearApiError();
    AppLoader.loading();
    ApiResult<GeneralResponse> result = await ProfileRepositoryImpl().changePassword(
      oldPassword: oldPasswordController.text,
      newPassword: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );
    AppLoader.dismiss();
    if (result.isSuccess()) {
      InformationViewer.showSuccessToast(msg: result.getData().message);
      Get.back(result: true);
    } else {
      InformationViewer.showSnackBar(
        msg: result.getError().trimLeft(),
        bgColor: mounted ? context.kErrorColor : Colors.red,
      );
      List<String> errors = result.getError().split('\n');

      for (String error in errors) {
        if (error.contains('Current password')) {
          oldPasswordState.currentState?.addApiError(error);
        } else if (error.contains('New password')) {
          passwordState.currentState?.addApiError(error);
        }
      }
    }
  }
}
