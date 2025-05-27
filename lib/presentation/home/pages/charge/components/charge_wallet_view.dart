import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/controller/home_controller.dart';

import '../../../../../config/constants.dart';
import '../../../../../config/res.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../widgets/bottom_sheet_header.dart';

class ChargeWalletView extends StatelessWidget {
  final String balance;
  const ChargeWalletView({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SvgPicture.asset(
            Res.chargeWalletIcon,
          ),
        ),
        20.ph,
        Center(
          child: AppText(
            text: 'insufficient_balance'.tr,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: AppText(
              text: '$balance EGP',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.kErrorColor,
            ),
          ),
        ),
        20.ph,
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: AppText(
              text: 'insufficient_balance_message'.tr,
              color: context.kHintTextColor,
              fontWeight: FontWeight.w300,
              centerText: true,
              maxLines: 4,
            ),
          ),
        ),
        20.ph,
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ElevatedButton(
              onPressed: () async {
                Get.back();
                HomeController.to.handleSelectedIndex(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: AppText(
                text: "charge_wallet".tr,
                color: context.kColorOnPrimary,
              ),
            ),
          ),
        ),
        40.ph,
      ],
    );
  }
}
