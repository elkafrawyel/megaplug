import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/charging_session/charging_session_screen.dart';
import 'package:megaplug/presentation/home/pages/charge/controller/charge_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../../config/res.dart';
import '../../../common_screens/how_to_charge_screen.dart';
import '../../components/home_appbar.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charge'.tr,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          80.ph,
          SvgPicture.asset(
            Res.chargePicIcon,
            height: MediaQuery.sizeOf(context).width * 0.6,
          ),
          40.ph,
          AppText(
            text: 'ready_for_scan'.tr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: AppText(
              text: 'charge_description'.tr,
              maxLines: 3,
              centerText: true,
              color: context.kHintTextColor,
              height: 2,
            ),
          ),
          10.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(text: 'have_any_trouble'.tr),
              5.pw,
              InkWell(
                onTap: () {
                  Get.to(() => HowToChargeScreen());
                },
                child: AppText(
                  text: 'how_to_charge'.tr,
                  color: context.kPrimaryColor,
                ),
              ),
            ],
          ),
          50.ph,
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ChargeController.to.setTransactionId('sadfasf');
                Get.to(()=>ChargingSessionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: AppText(
                  text: 'start_charging'.tr,
                  color: context.kColorOnPrimary,
                ),
              ),
            ),
          ),
          10.ph,
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: context.kErrorColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                ChargeController.to.stopCharge();
              },
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: AppText(
                  text: 'Stop Charging'.tr,
                  color: context.kColorOnPrimary,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
