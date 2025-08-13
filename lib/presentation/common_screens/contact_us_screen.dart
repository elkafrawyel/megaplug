import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/app_text_field/rules.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  GlobalKey<AppTextFormFieldState> nameState = GlobalKey();
  GlobalKey<AppTextFormFieldState> emailState = GlobalKey();
  GlobalKey<AppTextFormFieldState> phoneState = GlobalKey();
  GlobalKey<AppTextFormFieldState> messageState = GlobalKey();

  @override
  void initState() {
    super.initState();
    UserModel? userModel = Get.find<ProfileController>().userModel;
    nameController.text = userModel?.name ?? '';
    emailController.text = userModel?.email ?? '';
    phoneController.text = userModel?.phone ?? '';
  }

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'contact_us'.tr,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.ph,
              AppText(
                text: 'name'.tr,
                fontWeight: FontWeight.w700,
              ),
              10.ph,
              AppTextFormField(
                key: nameState,
                controller: nameController,
                hintText: 'name_hint'.tr,
                textInputAction: TextInputAction.next,
                autoFillHints: [AutofillHints.name],
                keyboardType: TextInputType.name,
                appFieldType: AppFieldType.name,
              ),
              20.ph,
              AppText(
                text: 'email'.tr,
                fontWeight: FontWeight.w700,
              ),
              10.ph,
              AppTextFormField(
                key: emailState,
                controller: emailController,
                hintText: 'email_hint'.tr,
                textInputAction: TextInputAction.next,
                autoFillHints: [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                appFieldType: AppFieldType.email,
                checkRulesOnTyping: false,
                rules: AppTextFieldRules.emailRules,
                onFieldSubmitted: (String value) {
                  AppTextFieldRules.validateForm(
                    [
                      emailState,
                    ],
                  );
                },
                onFocusLost: () {
                  AppTextFieldRules.validateForm(
                    [
                      emailState,
                    ],
                  );
                },
              ),
              20.ph,
              AppText(
                text: 'phone'.tr,
                fontWeight: FontWeight.w700,
              ),
              10.ph,
              AppTextFormField(
                key: phoneState,
                controller: phoneController,
                hintText: 'phone_hint'.tr,
                textInputAction: TextInputAction.next,
                autoFillHints: [AutofillHints.telephoneNumber],
                keyboardType: TextInputType.phone,
                appFieldType: AppFieldType.phone,
                rules: AppTextFieldRules.phoneNumberRules,
                onFieldSubmitted: (String value) {
                  AppTextFieldRules.validateForm(
                    [
                      phoneState,
                    ],
                  );
                },
                onFocusLost: () {
                  AppTextFieldRules.validateForm(
                    [
                      phoneState,
                    ],
                  );
                },
              ),
              20.ph,
              AppText(
                text: 'message'.tr,
                fontWeight: FontWeight.w700,
              ),
              10.ph,
              AppTextFormField(
                key: messageState,
                controller: messageController,
                hintText: 'message_hint'.tr,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                appFieldType: AppFieldType.name,
                maxLines: 5,
              ),
              30.ph,
              AppButton(
                onPressed: () {
                  _sendMessage();
                },
                text: 'send'.tr,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() async {
    if (!AppTextFieldRules.validateForm(
      [
        nameState,
        emailState,
        phoneState,
        messageState,
      ],
    )) {
      return;
    }
    AppLoader.loading();
    await Future.delayed(const Duration(seconds: 2));
    AppLoader.dismiss();
  }
}
