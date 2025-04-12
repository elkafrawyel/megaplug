import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/rules.dart';

import '../../../config/helpers/regex.dart';
import '../../home/controller/home_binding.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../home/home_screen.dart';
import '../components/wavy_appbar.dart';
import '../forget_password/forget_password_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> emailState = GlobalKey();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  final GlobalKey<FormState> formKey = GlobalKey();

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
            WavyAppBar(
              withBackButton: false,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
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
                      key: emailState,
                      controller: emailController,
                      hintText: "enter_email_or_phone".tr,
                      validateEmptyText: 'email_or_phone_required'.tr,
                      rules: emailOrPhoneRules,
                      autoFillHints: const [
                        AutofillHints.email,
                        AutofillHints.telephoneNumber
                      ],
                    ),
                    16.ph,
                    AppText(text: "password".tr),
                    16.ph,
                    AppTextFormField(
                      key: passwordState,
                      controller: passwordController,
                      hintText: "enter_password".tr,
                      appFieldType: AppFieldType.password,
                      validateEmptyText: 'password_required'.tr,
                      autoFillHints: const [AutofillHints.password],
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
                        _login();
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
            ),
          ],
        ),
      ),
    );
  }

  _login() async {
    if (emailController.text.isEmpty ||
        (emailState.currentState?.hasError ?? false)) {
      emailState.currentState?.shake();
      return;
    }
    if (passwordController.text.isEmpty ||
        (passwordState.currentState?.hasError ?? false)) {
      passwordState.currentState?.shake();
      return;
    }

    Get.offAll(
      () => HomeScreen(),
      binding: HomeBinding(),
    );
  }

  bool validateEmailOrPhone(String value) {
    String input = value.trim();

    print(input);
    if (isEmail(input)) {
      print('User entered an email');
      return true;
    } else if (isPhone(input)) {
      if (isEgyptianPhone(input)) {
        print('Entered an Egyptian phone number');
        return true;
      } else {
        print('Entered a phone number, but not Egyptian');
        return true;
      }
    } else {
      print('Input is neither valid email nor phone number');
      return false;
    }
  }
}
