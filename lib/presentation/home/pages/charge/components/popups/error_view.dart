import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../../../../config/constants.dart';
import '../../../../../../config/res.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        10.ph,
        SvgPicture.asset(Res.disconnectedIcon),
        20.ph,
        AppText(
          text: 'oops'.tr,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        10.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38.0),
          child: AppText(
            text:
                'try_again'.tr,
            color: context.kHintTextColor,
            fontWeight: FontWeight.w300,
            centerText: true,
            maxLines: 2,
          ),
        ),
        20.ph,
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9,
          child: ElevatedButton(
            onPressed: () async {
              // Get.back();
              // HomeController.to.handleSelectedIndex(1);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.kPrimaryColor,
              padding: EdgeInsets.symmetric(vertical: kButtonHeight),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: AppText(
              text: "try_to_connect".tr,
              color: context.kColorOnPrimary,
            ),
          ),
        ),
        40.ph,
      ],
    );
  }
}
