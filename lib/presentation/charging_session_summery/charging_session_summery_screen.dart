import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';

import '../../config/constants.dart';
import '../../config/res.dart';
import '../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../charging_session/components/metric_cardView.dart';
import '../charging_session/components/rate_view.dart';
import '../home/pages/wallet/components/points_view.dart';

class ChargingSessionSummeryScreen extends StatelessWidget {
  const ChargingSessionSummeryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charging'.tr,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 38.0,
          horizontal: 18.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 38.0,
                    horizontal: 18.0,
                  ),
                  child: Column(
                    children: [
                      AppText(
                        text: 'Tesla Model X',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      10.ph,
                      AppText(
                        text: 'ChargePoint Station - Chilout Madinaty',
                        color: context.kHintTextColor,
                      ),
                      5.ph,
                      AppText(
                        text: 'ID#135675323',
                        color: context.kHintTextColor,
                      ),
                      20.ph,
                      SvgPicture.asset(
                        Res.chargeCompleteIcon,
                        width: 60,
                        height: 60,
                      ),
                      20.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                              text: 'Charging',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: AppText(
                                text: '100%',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          AppText(
                              text: 'Complete!',
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              20.ph,
              Row(
                children: [
                  Expanded(
                    child: MetricCardView(
                      title: "4500 KW",
                      subtitle: "Total kilowatt\nconsumed",
                      assetName: Res.totalWattIcon,
                    ),
                  ),
                  Expanded(
                    child: MetricCardView(
                      title: "15.12 EGP",
                      subtitle: "Total cost accrued\nfor this charge",
                      assetName: Res.totalCostIcon,
                    ),
                  ),
                ],
              ),
              20.ph,
              PointsView(
                points: 320,
              ),
              30.ph,
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!context.mounted) return;
                      showAppModalBottomSheet(
                        context: context,
                        child: RateView(),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.kPrimaryColor,
                      padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: AppText(
                      text: "disconnect_charging".tr,
                      color: context.kColorOnPrimary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
