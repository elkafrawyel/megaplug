import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/auth/new_password/new_password_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/wavy_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'components/ArabicToEnglishNumberFormatter.dart';

class OtpCodeScreen extends StatefulWidget {
  const OtpCodeScreen({super.key});

  @override
  State<OtpCodeScreen> createState() => _OtpCodeScreenState();
}

class _OtpCodeScreenState extends State<OtpCodeScreen> {
  final TextEditingController codeController = TextEditingController();
  late Timer _timer;
  Timer? _debounce;
  StreamController<ErrorAnimationType>? errorController;
  int seconds = 0;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    initializeTimer();

    super.initState();
  }

  initializeTimer() {
    seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        seconds--;
        if (seconds == 0) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    _timer.cancel();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    String time = '${seconds % 60}'.padLeft(2, '0');
    // String time =
    //        '${'${(seconds / 60).floor()}'.padLeft(2, '0')}:${'${seconds % 60}'.padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WavyAppBar(),
          AppText(
            text: 'otp_code'.tr,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: AppText(
              text: 'otp_code_message'.tr,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: context.kHintTextColor,
              maxLines: 3,
              centerText: true,
            ),
          ),
          30.ph,
          Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              inputFormatters: [
                ArabicToEnglishNumberFormatter(),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.green.shade600,
                fontWeight: FontWeight.bold,
              ),
              textStyle: const TextStyle(fontSize: 20),
              length: 4,
              obscureText: false,
              // obscuringCharacter: '*',
              // obscuringWidget: const FlutterLogo(
              //   size: 24,
              // ),
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              // validator: (v) {
              //   if (v!.length < 3) {
              //     return "I'm from validator";
              //   } else {
              //     return null;
              //   }
              // },
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: 50,
                fieldWidth: 60,
                borderWidth: 0.65,
                activeColor: Color.fromRGBO(62, 191, 128, 0.1),
                selectedColor: Color.fromRGBO(62, 191, 128, 0.1),
                activeFillColor: Colors.white,
                selectedFillColor: const Color.fromRGBO(62, 191, 128, 0.1),
                inactiveFillColor: const Color.fromRGBO(250, 250, 250, 1),
                inactiveColor: const Color.fromRGBO(250, 250, 250, 1),
                fieldOuterPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
              ),
              cursorColor: Theme.of(context).primaryColor,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              controller: codeController,
              keyboardType: TextInputType.number,
              // boxShadows: const [
              //   BoxShadow(
              //     offset: Offset(0, 1),
              //     color: Colors.black12,
              //     blurRadius: 10,
              //   )
              // ],
              onCompleted: (verificationCode) {
                if (_debounce?.isActive ?? false) {
                  _debounce?.cancel();
                }
                _debounce = Timer(
                  const Duration(milliseconds: 500),
                  () {
                    sendVerificationCode(verificationCode);
                  },
                );
              },
              onChanged: (value) {
                // debugPrint(value);
                // setState(() {
                //   otpCode = value;
                // });
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                return true;
              },
            ),
          ),
          30.ph,
          AppText(text: "Didn't receive Code?"),
          10.ph,
          _timer.isActive
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: 'you_can_send'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      text: " $time ",
                      color: context.kPrimaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      text: 'second'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    //send code again
                    initializeTimer();
                    // context.read<ResetPasswordCubit>().resetPassword(
                    //       email: email,
                    //       isOptScreen: true,
                    //     );
                    setState(() {
                      codeController.clear();
                    });
                  },
                  child: AppText(
                    text: 'resend'.tr,
                    color: context.kPrimaryColor,
                    fontSize: 16,
                  ),
                )
        ],
      ),
    );
  }

  void sendVerificationCode(String verificationCode) async {
    if (verificationCode.isNotEmpty) {
      Get.to(() => NewPasswordScreen());
    }
  }
}
