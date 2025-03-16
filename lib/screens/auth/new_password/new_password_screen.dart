import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/auth/login/login_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/wavy_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppText(
                  text: 'new_password_message'.tr,
                  maxLines: 3,
                  color: context.kHintTextColor,
                  centerText: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText(
                text: 'new_password'.tr,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextFormField(
                controller: passwordController,
                hintText: 'new_password_hint'.tr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText(
                text: 're_inter_new_password'.tr,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppTextFormField(
                controller: confirmPasswordController,
                hintText: 're_inter_new_password_hint'.tr,
              ),
            ),
            150.ph,
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: AppButton(
                text: 'change_password'.tr,
                onPressed: () {
                  Get.offAll(() => LoginScreen());
                },
              ),
            ),
            100.ph,
          ],
        ),
      ),
    );
  }
}
