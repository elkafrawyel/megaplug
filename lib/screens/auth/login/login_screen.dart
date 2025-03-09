import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/auth/components/wavy_appbar.dart';
import 'package:megaplug/screens/auth/forget_password/forget_password_screen.dart';
import 'package:megaplug/screens/auth/register/register_screen.dart';
import 'package:megaplug/screens/home_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

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
                      text: "Welcome back !",
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: AppText(
                      text:
                          "Sign in to access all features, manage your settings, and enjoy a seamless app experience.",
                      color: Color(0xff6D7698),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      maxLines: 4,
                      centerText: true,
                    ),
                  ),
                  24.ph,
                  AppText(text: "Email / Phone"),
                  16.ph,
                  AppTextFormField(
                    controller: TextEditingController(),
                    hintText: "Please enter email or phone",
                  ),
                  16.ph,
                  AppText(text: "Password"),
                  16.ph,
                  AppTextFormField(
                    controller: TextEditingController(),
                    hintText: "Please enter password",
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
                        text: "Forget password ?",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    child: AppButton(
                      text: 'Login',
                      onPressed: () {
                        Get.to(() => HomeScreen());
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(text: "Don't have an account?"),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => RegisterScreen());
                        },
                        child: AppText(
                          text: "Create new Account",
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
