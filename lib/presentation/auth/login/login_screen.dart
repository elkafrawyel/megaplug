import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_requests/login_request.dart';
import 'package:megaplug/data/api_responses/login_response.dart';
import 'package:megaplug/data/repositories/auth_repo.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/rules.dart';

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
  AuthRepositoryImpl authRepositoryImpl = AuthRepositoryImpl();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> emailState = GlobalKey();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // emailController.text = '01019744661';
    // passwordController.text = 'Flutter123456!';
  }

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
                      rules: AppTextFieldRules.emailOrPhoneRules,
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
                      autoFillHints: const [AutofillHints.password],
                    ),
                    16.ph,
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => ForgetPasswordScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppText(
                            text: "forget_password?".tr,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
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
    FocusScope.of(context).unfocus();

    bool validated = AppTextFieldRules.validateForm(
      [
        emailState,
        passwordState,
      ],
    );
    if (!validated) {
      return;
    }
    AppLoader.loading();
    ApiResult<LoginResponse> apiResult = await authRepositoryImpl.login(
      loginRequest: LoginRequest(
        username: emailController.text,
        password: passwordController.text,
      ),
    );

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      LoginResponse loginResponse = apiResult.getData();

      InformationViewer.showSuccessToast(msg: loginResponse.message);

      await StorageClient().saveUser(userResponse: loginResponse.data);

      Get.offAll(
        () => HomeScreen(),
        binding: HomeBinding(),
      );
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
