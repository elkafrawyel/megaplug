import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';
import 'package:megaplug/presentation/change_password/change_password_screen.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_image_picker_dialog.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../../widgets/app_widgets/app_text_field/rules.dart';
import '../home/components/home_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  GlobalKey<AppTextFormFieldState> nameState = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  GlobalKey<AppTextFormFieldState> emailState = GlobalKey();

  final TextEditingController phoneController = TextEditingController();
  GlobalKey<AppTextFormFieldState> phoneState = GlobalKey();

  @override
  void initState() {
    UserModel? userModel = Get.find<ProfileController>().userModel;
    nameController.text = userModel?.name ?? '';
    emailController.text = userModel?.email ?? '';
    phoneController.text = userModel?.phone ?? '';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor = Color(0xff9DB2CE);
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        height: 70,
        // Custom height
        title: 'edit_profile'.tr,
        showBackButton: true,
        svgOpacity: 1.0,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 46.0,
          horizontal: 18.0,
        ),
        child: AppButton(
          onPressed: () {},
          text: 'edit_profile'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ProfileController>(builder: (profileController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                70.ph,
                GestureDetector(
                  onTap: () {
                    showAppImageDialog(
                      context: context,
                      onFilePicked: (File? file) {
                        profileController.profileImage = file;
                      },
                    );
                  },
                  child: Center(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: borderColor,
                              width: 4,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: AppNetworkImage(
                            imageUrl: profileController.userModel?.avatar ?? '',
                            isCircular: true,
                            localFile: profileController.profileImage,
                            height: 100,
                            width: 100,
                            fit: BoxFit.fitHeight,
                            borderColor: borderColor,
                            borderWidth: 2,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
                    key: nameState,
                    controller: nameController,
                    hintText: 'name_hint'.tr,
                    textInputAction: TextInputAction.next,
                    autoFillHints: [AutofillHints.name],
                    appFieldType: AppFieldType.name,
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
                    key: emailState,
                    controller: emailController,
                    hintText: 'email_hint'.tr,
                    textInputAction: TextInputAction.next,
                    autoFillHints: [AutofillHints.email],
                    appFieldType: AppFieldType.email,
                    rules: AppTextFieldRules.emailRules,
                    checkRulesOnTyping: false,
                    onFieldSubmitted: (String value) {
                      AppTextFieldRules.validateForm(
                        [
                          emailState,
                        ],
                      );
                    },
                    onFocusLost: (){
                      AppTextFieldRules.validateForm(
                        [
                          emailState,
                        ],
                      );
                    },
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
                    key: phoneState,
                    controller: phoneController,
                    hintText: 'phone_hint'.tr,
                    appFieldType: AppFieldType.phone,
                    textInputAction: TextInputAction.next,
                    autoFillHints: [AutofillHints.telephoneNumber],
                    rules: AppTextFieldRules.phoneNumberRules,
                    checkRulesOnTyping: false,
                    onFieldSubmitted: (String value) {
                      AppTextFieldRules.validateForm(
                        [
                          phoneState,
                        ],
                      );
                    },
                    onFocusLost: (){
                      AppTextFieldRules.validateForm(
                        [
                          phoneState,
                        ],
                      );
                    },
                  ),
                ),
                30.ph,
                GestureDetector(
                  onTap: () {
                    Get.to(() => ChangePasswordScreen());
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadius),
                      border: Border.all(
                        color: context.kPrimaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: AppText(
                          text: 'change_password'.tr,
                          color: context.kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
