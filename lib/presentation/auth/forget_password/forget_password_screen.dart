import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../config/app_loader.dart';
import '../../../config/clients/api/api_result.dart';
import '../../../config/information_viewer.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../widgets/app_widgets/app_text_field/rules.dart';
import '../components/wavy_appbar.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../otp_code/otp_code_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<AppTextFormFieldState> emailState = GlobalKey();
  final TextEditingController emailController = TextEditingController();

  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WavyAppBar(
              withBackButton: true,
            ),
            20.ph,
            Center(
              child: AppText(
                text: 'forget_password'.tr,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.ph,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppText(
                  text: 'forget_password_message'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  centerText: true,
                  color: context.kHintTextColor,
                  maxLines: 3,
                ),
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: "email_or_phone".tr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                key: emailState,
                controller: emailController,
                hintText: "enter_email_or_phone".tr,
                rules: AppTextFieldRules.emailOrPhoneRules,
                autoFillHints: const [
                  AutofillHints.email,
                  AutofillHints.telephoneNumber
                ],
              ),
            ),
            200.ph,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppButton(
                text: 'send_otp'.tr,
                onPressed: () {
                  _senOtp();
                },
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: 'remember_the_password'.tr,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
                5.pw,
                GestureDetector(
                  onTap: Get.back,
                  child: AppText(
                    text: 'login'.tr,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: context.kPrimaryColor,
                  ),
                )
              ],
            ),
            50.ph,
          ],
        ),
      ),
    );
  }

  void _senOtp() async {
    if (emailController.text.isEmpty ||
        (emailState.currentState?.hasError ?? false)) {
      emailState.currentState?.shake();
      return;
    }

    AppLoader.loading();
    ApiResult<GeneralResponse> apiResult = await authRepositoryImpl.sendOtp(
      username: emailController.text,
    );

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      GeneralResponse loginResponse = apiResult.getData();

      InformationViewer.showSuccessToast(msg: loginResponse.message);

      Get.to(() => OtpCodeScreen());
    } else {
      if (mounted) {
        InformationViewer.showSnackBar(
          msg: apiResult.getError(),
          bgColor: context.kErrorColor,
        );
      }
    }
  }
}
