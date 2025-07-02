import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_requests/register_request.dart';
import 'package:megaplug/data/api_responses/register_response.dart';
import 'package:megaplug/data/repositories/auth_repo.dart';
import 'package:megaplug/presentation/auth/otp_code/otp_code_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/rules.dart';

import '../../../config/res.dart';
import 'components/register_appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  final TextEditingController nameController = TextEditingController();
  GlobalKey<AppTextFormFieldState> nameState = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  GlobalKey<AppTextFormFieldState> emailState = GlobalKey();

  final TextEditingController phoneController = TextEditingController();
  GlobalKey<AppTextFormFieldState> phoneState = GlobalKey();

  final TextEditingController passwordController = TextEditingController();
  GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<AppTextFormFieldState> confirmPasswordState = GlobalKey();

  @override
  void initState() {
    super.initState();
    // nameController.text = 'Mahmoud';
    // emailController.text = 'mahmoud@gmail.com';
    // phoneController.text = '01019744661';
    // passwordController.text = 'Flutter123456!';
    // confirmPasswordController.text = 'Flutter123456!';
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 'name'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  key: nameState,
                  controller: nameController,
                  hintText: 'name_hint'.tr,
                  textInputAction: TextInputAction.next,
                  autoFillHints: [AutofillHints.name],
                  appFieldType: AppFieldType.name,
                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 'email'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  key: emailState,
                  controller: emailController,
                  hintText: 'email_hint'.tr,
                  checkRulesOnTyping: false,
                  textInputAction: TextInputAction.next,
                  autoFillHints: [AutofillHints.email],
                  appFieldType: AppFieldType.email,
                  rules: AppTextFieldRules.emailRules,
                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 'phone'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  key: phoneState,
                  controller: phoneController,
                  hintText: 'phone_hint'.tr,
                  appFieldType: AppFieldType.phone,
                  textInputAction: TextInputAction.next,
                  autoFillHints: [AutofillHints.telephoneNumber],
                  rules: AppTextFieldRules.phoneNumberRules,
                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 'password'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  key: passwordState,
                  controller: passwordController,
                  hintText: 'enter_password'.tr,
                  appFieldType: AppFieldType.password,
                  textInputAction: TextInputAction.next,
                  rules: AppTextFieldRules.passwordRules,
                  alwaysShowRules: true,

                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 're_inter_password'.tr,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: AppTextFormField(
                  key: confirmPasswordState,
                  controller: confirmPasswordController,
                  hintText: 're_inter_password_hint'.tr,
                  appFieldType: AppFieldType.password,
                  textInputAction: TextInputAction.done,
                  alwaysShowRules: false,
                  checkRulesOnTyping: false,
                ),
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Wrap(
                  children: [
                    AppText(
                      text: 'agree_to'.tr,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff6D7698),
                    ),
                    5.pw,
                    GestureDetector(
                      onTap: () {},
                      child: AppText(
                        text: 'terms'.tr,
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: context.kPrimaryColor,
                      ),
                    )
                  ],
                ),
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  text: 'register'.tr,
                  onPressed: () {
                    _register();
                  },
                ),
              ),
              50.ph,
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    FocusScope.of(context).unfocus();

    bool validated = AppTextFieldRules.validateForm(
      [
        nameState,
        emailState,
        phoneState,
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

    ApiResult<RegisterResponse> apiResult = await authRepositoryImpl.register(
      registerRequest: RegisterRequest(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        language: StorageClient().getAppLanguage().toUpperCase(),
      ),
    );

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      RegisterResponse registerResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: registerResponse.message);

      Get.offAll(
        () => OtpCodeScreen(
          username: phoneController.text,
          fromRegisterScreen: true,
        ),
      );
    } else {
      InformationViewer.showSnackBar(
        msg: apiResult.getError().trimLeft(),
        bgColor: mounted ? context.kErrorColor : Colors.red,
      );
      List<String> errors = apiResult.getError().split('\n');

      for (String error in errors) {
        if (error.contains('phone')) {
          phoneState.currentState?.addApiError(error);
        } else if (error.contains('email')) {
          emailState.currentState?.addApiError(error);
        }
      }
    }
  }
}
