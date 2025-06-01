import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/charging_session_summery/charging_session_summery_screen.dart';
import 'package:megaplug/presentation/home/pages/charge/controller/charge_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/bottom_sheet_header.dart';

import '../../../config/res.dart';

class StopChargingView extends StatelessWidget {
  const StopChargingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusDirectional.vertical(
          top: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeader(),
            10.ph,
            Center(
              child: SvgPicture.asset(
                Res.warningIcon,
              ),
            ),
            20.ph,
            Center(
              child: AppText(
                text: 'stop_charging'.tr,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            20.ph,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppText(
                  text: 'stop_charging_desc'.tr,
                  color: context.kHintTextColor,
                  fontWeight: FontWeight.w300,
                  centerText: true,
                  maxLines: 4,
                ),
              ),
            ),
            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.kPrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: AppText(
                        text: "change_my_mind".tr,
                        color: context.kColorOnPrimary,
                      ),
                    ),
                  ),
                  10.pw,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await ChargeController.to.stopCharge();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.kErrorColor,
                        padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: AppText(
                        text: "stop_charging".tr,
                        color: context.kColorOnPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            40.ph,
          ],
        ),
      ),
    );
  }
}
