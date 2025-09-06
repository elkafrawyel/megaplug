import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import '../config/constants.dart';
import 'app_widgets/app_text.dart';

// Get.dialog(
//   AppDialogView(
//     svgName: Res.iconSuccess,
//     title: 'Congratulations!',
//     message: 'Your account is ready to use',
//     actionText: 'Go to Homepage',
//     onActionClicked: () {},
//   ),
// );

// Get.dialog(
//   AppDialogView(
//     svgName: Res.iconLocation,
//     title: 'Congratulations!',
//     message: 'Your account is ready to use',
//     actionText: 'Go to Homepage',
//     onActionClicked: () {},
//   ),
// );

// Get.dialog(
// AppDialogView(
// svgName: Res.iconPhoneVerified,
// title: 'Congratulations!',
// message: 'Your account is ready to use',
// actionText: 'Go to Homepage',
// onActionClicked: () {},
// ),
// );
class AppDialogView extends StatelessWidget {
  final String? svgName;
  final String title;
  final String message;
  final String actionText;
  final VoidCallback onActionClicked;

  const AppDialogView({
    super.key,
    this.svgName,
    required this.title,
    required this.message,
    required this.actionText,
    required this.onActionClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Card(
              color: context.kBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: title,
                      fontSize: 20,
                      color: context.kPrimaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 18,
                      ),
                      child: AppText(
                        text: message,
                        maxLines: 6,
                        centerText: true,
                        color: context.kHintTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    10.ph,
                    AppButton(
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      onPressed: onActionClicked.call,
                      text: actionText,
                    )
                  ],
                ),
              ),
            )));
  }
}
