import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/wavy_appbar.dart';
import 'package:megaplug/screens/auth/forget_password/forget_password_screen.dart';
import 'package:megaplug/screens/auth/register/register_screen.dart';
import 'package:megaplug/screens/home/home_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../controller/home/home_binding.dart';
import '../../../widgets/app_widgets/app_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            WavyAppBar(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: AppText(
                      text: "welcome_back".tr,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: AppText(
                      text: "login_message".tr,
                      color: Color(0xff6D7698),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      maxLines: 4,
                      centerText: true,
                    ),
                  ),
                  24.ph,
                  AppText(
                    text: "email_or_phone".tr,
                  ),
                  16.ph,
                  AppTextFormField(
                    controller: TextEditingController(),
                    hintText: "enter_email_or_phone".tr,
                  ),
                  16.ph,
                  AppText(text: "password".tr),
                  16.ph,
                  AppTextFormField(
                    controller: TextEditingController(),
                    hintText: "enter_password".tr,
                    appFieldType: AppFieldType.password,
                  ),
                  16.ph,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => ForgetPasswordScreen());
                      },
                      child: AppText(
                        text: "forget_password?".tr,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  AppButton(
                    text: 'login'.tr,
                    onPressed: () {
                      Get.to(
                        () => HomeScreen(),
                        binding: HomeBinding(),
                      );
                    },
                  ),
                  20.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(text: "don't_have_account".tr),
                      5.pw,
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: AppText(
                          text: "create_account".tr,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: context.kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                  100.ph,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
