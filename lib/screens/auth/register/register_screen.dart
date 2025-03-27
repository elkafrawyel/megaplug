import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/home/home_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../config/res.dart';
import '../../home/controller/home_binding.dart';
import 'components/register_appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: RegisterAppbar(
        svgAssetPath: Res.registerAppBarBgIcon,
        title: 'register'.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'name'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                controller: nameController,
                hintText: 'name_hint'.tr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'email'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                controller: emailController,
                hintText: 'email_hint'.tr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'phone'.tr,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppTextFormField(
                controller: phoneController,
                hintText: 'phone_hint'.tr,
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
                controller: passwordController,
                hintText: 'enter_password'.tr,
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
                controller: confirmPasswordController,
                hintText: 're_inter_password_hint'.tr,
              ),
            ),
            100.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppButton(
                text: 'register'.tr,
                onPressed: () {
                  Get.to(
                    () => HomeScreen(),
                    binding: HomeBinding(),
                  );
                },
              ),
            ),
            200.ph,
          ],
        ),
      ),
    );
  }
}
