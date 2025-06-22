import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/firebase/firebase_charging_session_model.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';

import '../../config/constants.dart';
import '../../config/res.dart';
import '../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../../widgets/bottom_sheet_parent.dart';
import '../charging_session/components/metric_cardView.dart';
import '../charging_session/components/rate_view.dart';
import '../home/controller/home_controller.dart';
import '../home/pages/charge/components/popups/charge_wallet_view.dart';
import '../home/pages/profile/controller/profile_controller.dart';
import '../home/pages/wallet/components/points_view.dart';

class ChargingSessionSummeryScreen extends StatelessWidget {
  final FirebaseChargingSessionModel chargingModel;

  const ChargingSessionSummeryScreen({super.key, required this.chargingModel});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      if (chargingModel.error == 'Insufficient balance') {
        showAppModalBottomSheet(
          context: context,
          child: BottomSheetParent(
            child: ChargeWalletView(
              data: {
                'balance': chargingModel.userBalance?.toDouble().toStringAsFixed(2),
                'min_balance': chargingModel.price,
              },
              redirectAction: () {
                Get.until((route) => route.settings.name == '/HomeScreen');
                Future.delayed(
                    (Duration(
                      milliseconds: 500,
                    )), () {
                  HomeController.to.handleSelectedIndex(1);
                });
              },
            ),
          ),
        );
      }
    });
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charging'.tr,
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
                      GetBuilder<ProfileController>(
                        builder: (profileController) {
                          return AppText(
                            text: StorageClient().isAr()
                                ? "${profileController.userModel?.name ?? ''} سيارة"
                                : "${profileController.userModel?.name ?? ''} 's Car",
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          );
                        },
                      ),
                      10.ph,
                      AppText(
                        text: "${chargingModel.name} - ${chargingModel.address}",
                        color: context.kHintTextColor,
                        maxLines: 2,
                        fontSize: 12,
                        centerText: true,
                        fontWeight: FontWeight.w500,
                      ),
                      5.ph,
                      AppText(
                        text: "#${chargingModel.chargingPointSerialNumber ?? 'N/A'}",
                        color: context.kHintTextColor,
                        fontSize: 12,
                      ),
                      20.ph,
                      SvgPicture.asset(
                        Res.chargeCompleteIcon,
                        width: 90,
                        height: 90,
                      ),
                      20.ph,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'charging'.tr,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          5.pw,
                          if (chargingModel.currentSoC != null)
                            AppText(
                              text: '${chargingModel.currentSoC}%',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          if (chargingModel.currentSoC != null) 5.pw,
                          AppText(
                            text: '${'complete'.tr}!',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
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
                      title: "${chargingModel.energyDelivered?.toStringAsFixed(2) ?? '0.0'} ${'kw'.tr}",
                      subtitle: "total_watts".tr,
                      assetName: Res.totalWattIcon,
                    ),
                  ),
                  Expanded(
                    child: MetricCardView(
                      title: "${chargingModel.overallCost?.toStringAsFixed(2) ?? '0.0'} ${'egp'.tr}",
                      subtitle: "total_cost".tr,
                      assetName: Res.totalCostIcon,
                    ),
                  ),
                ],
              ),
              // 20.ph,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: PointsView(
                  points: chargingModel.loyalityPoints?.toDouble() ?? 0.0,
                ),
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
