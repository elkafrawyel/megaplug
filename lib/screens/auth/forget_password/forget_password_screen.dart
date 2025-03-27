import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/auth/otp_code/otp_code_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../components/wavy_appbar.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

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
                controller: TextEditingController(),
                hintText: "enter_email_or_phone".tr,
              ),
            ),
            200.ph,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: AppButton(
                text: 'send_otp'.tr,
                onPressed: () {
                  Get.to(()=>OtpCodeScreen());
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
            )
          ],
        ),
      ),
    );
  }
}
