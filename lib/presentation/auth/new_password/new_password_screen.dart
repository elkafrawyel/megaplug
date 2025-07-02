import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/repositories/auth_repo.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../data/api_requests/reset_password_request.dart';
import '../../../widgets/app_widgets/app_text_field/rules.dart';
import '../components/wavy_appbar.dart';
import '../login/login_screen.dart';

class NewPasswordScreen extends StatefulWidget {
  final String otp;
  final String username;

  const NewPasswordScreen({
    super.key,
    required this.otp,
    required this.username,
  });

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  final TextEditingController passwordController = TextEditingController();
  GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<AppTextFormFieldState> confirmPasswordState = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            WavyAppBar(),
            Center(
              child: AppText(
                text: 'new_password'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: AppText(
                  text: 'new_password_message'.tr,
                  maxLines: 3,
                  color: context.kHintTextColor,
                  centerText: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppText(
                text: 'new_password'.tr,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppTextFormField(
                controller: passwordController,
                hintText: 'new_password_hint'.tr,
                key: passwordState,
                appFieldType: AppFieldType.password,
                textInputAction: TextInputAction.next,
                rules: AppTextFieldRules.passwordRules,
                alwaysShowRules: true,

              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppText(
                text: 're_inter_new_password'.tr,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppTextFormField(
                controller: confirmPasswordController,
                hintText: 're_inter_new_password_hint'.tr,
                key: confirmPasswordState,
                appFieldType: AppFieldType.password,
                textInputAction: TextInputAction.done,
                alwaysShowRules: false,
                checkRulesOnTyping: false,
              ),
            ),
            40.ph,
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: AppButton(
                text: 'change_password'.tr,
                onPressed: () {
                  _changePassword();
                },
              ),
            ),
            50.ph,
          ],
        ),
      ),
    );
  }

  void _changePassword() async {
    FocusScope.of(context).unfocus();

    bool validated = AppTextFieldRules.validateForm(
      [
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

    AppLoader.loading();

    ApiResult<GeneralResponse> apiResult =
        await authRepositoryImpl.resetPassword(
      resetPasswordRequest: ResetPasswordRequest(
        username: widget.username,
        otp: widget.otp,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      ),
    );
    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      GeneralResponse generalResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.offAll(() => LoginScreen());
    } else {
      if (mounted) {
        InformationViewer.showSnackBar(
          msg: apiResult.getError().trim(),
          bgColor: context.kErrorColor,
        );
      }
    }
  }
}
