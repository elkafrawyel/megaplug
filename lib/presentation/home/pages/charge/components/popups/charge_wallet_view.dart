import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/controller/home_controller.dart';

import '../../../../../../config/constants.dart';
import '../../../../../../config/res.dart';
import '../../../../../../widgets/app_widgets/app_text.dart';

class ChargeWalletView extends StatelessWidget {
  // {balance: 0.00, min_balance: 3.75}
  final dynamic data;
  final VoidCallback redirectAction;

  const ChargeWalletView({
    super.key,
    required this.data,
    required this.redirectAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Res.emptyWalletIcon,
          width: 100,
          height: 100,
        ),
        20.ph,
        AppText(
          text: 'insufficient_balance'.tr,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        10.ph,
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Res.greenWalletIcon,
              width: 20,
            ),
            10.pw,
            AppText(
              text: 'current_balance'.tr,
              color: context.kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            5.pw,
            AppText(
              text: '${data['balance'] ?? 0.0} EGP',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: context.kErrorColor,
            ),
          ],
        ),
        20.ph,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
              children: <TextSpan>[
                TextSpan(
                  text: "You don't have sufficient funds in your wallet to proceed with the charging session. A minimum balance of ",
                  style: TextStyle(color: context.kHintTextColor, fontSize: 14),
                ),
                TextSpan(
                  text: '${data['min_balance'] ?? '0.0'} EGP',
                  style: TextStyle(
                    fontSize: 16,
                    color: context.kHintTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ' is required.\nPlease top up your wallet to continue.',
                  style: TextStyle(color: context.kHintTextColor, fontSize: 14),
                ),
              ],
            ),
            maxLines: 4,
            textAlign: TextAlign.center,
          ),
        ),
        20.ph,
        Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9,
            child: ElevatedButton(
              onPressed: redirectAction,
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
