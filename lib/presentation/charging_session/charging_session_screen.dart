import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../config/constants.dart';
import '../../config/res.dart';
import '../../domain/entities/firebase/firebase_charging_session_model.dart';
import '../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../home/components/home_appbar.dart';
import '../home/pages/charge/controller/charge_controller.dart';
import '../home/pages/profile/controller/profile_controller.dart';
import 'components/metric_cardView.dart';
import 'components/rounded_circle_painter.dart';
import 'components/stop_charging_view.dart';

class ChargingSessionScreen extends StatefulWidget {
  final String transactionId;

  const ChargingSessionScreen({super.key, required this.transactionId});

  @override
  State<ChargingSessionScreen> createState() => _ChargingSessionScreenState();
}

class _ChargingSessionScreenState extends State<ChargingSessionScreen> {
  @override
  void initState() {
    super.initState();
    ChargeController.to.setTransactionId(widget.transactionId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charging'.tr,
        showBackButton: true,
      ),
      body: GetBuilder<ChargeController>(
          id: ChargeController.chargingSessionControllerId,
          builder: (chargingController) {
            FirebaseChargingSessionModel? chargingSessionModel =
                chargingController.chargingSessionModel;
            if (chargingSessionModel == null) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      Res.chargingImage,
                      width: 200,
                      height: 200,
                    ),
                  ),
                ],
              );
            }
            int? percentage = chargingSessionModel.currentSoC;
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  children: [
                    // Car and station info
                    Center(
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            GetBuilder<ProfileController>(
                              builder: (profileController) {
                                return AppText(
                                  text:
                                      "${profileController.userModel?.name ?? ''} 's Car",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                );
                              },
                            ),
                            10.ph,
                            AppText(
                              text:
                                  "${chargingSessionModel.name} - ${chargingSessionModel.address}",
                              color: context.kHintTextColor,
                              maxLines: 2,
                              fontSize: 12,
                              centerText: true,
                              fontWeight: FontWeight.w500,
                            ),
                            5.ph,
                            AppText(
                              text:
                                  "#${chargingSessionModel.chargingPointSerialNumber ?? 'N/A'}",
                              color: context.kHintTextColor,
                              fontSize: 12,
                            ),
                            20.ph,
                            percentage != null
                                ? Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomPaint(
                                        size: Size(200, 200),
                                        painter: RoundedCirclePainter(
                                          percentage: percentage / 100,
                                          foregroundColor:
                                              context.kPrimaryColor,
                                          backgroundColor: Color(0xffF0FAF5),
                                        ),
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (chargingSessionModel.isDc ??
                                              false)
                                            Icon(
                                              Icons.flash_on,
                                              color: Colors.amber,
                                            ),
                                          AppText(
                                            text: "$percentage%",
                                            fontSize: 28,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          AppText(
                                            text:
                                                '${chargingSessionModel.chargingSpeed?.toStringAsFixed(2)} ${'kw'.tr} ${'power'.tr}',
                                            color: context.kHintTextColor,
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Res.chargingImage,
                                        width: 200,
                                        height: 200,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: AppText(
                                          text:
                                              '${chargingSessionModel.chargingSpeed?.toStringAsFixed(2)} ${'kw'.tr} ${'power'.tr}',
                                          color: context.kHintTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                            20.ph,
                            AppText(
                              text: "your_car_is_charging".tr,
                              color: context.kSecondaryColor,
                              fontFamily: 'Inter',
                            ),
                          ],
                        ),
                      ),
                    ),
                    20.ph,
                    // Metrics
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MetricCardView(
                            title: chargingController.elapsedTime ?? '00:00:00',
                            subtitle: "time_remaining".tr,
                            assetName: Res.timeIcon,
                          ),
                        ),
                        Expanded(
                          child: MetricCardView(
                            title:
                                "${chargingSessionModel.energyDelivered?.toStringAsFixed(2) ?? '0.0'} ${'kw'.tr}",
                            subtitle: "total_watts".tr,
                            assetName: Res.totalWattIcon,
                          ),
                        ),
                        Expanded(
                          child: MetricCardView(
                            title:
                                "${chargingSessionModel.overallCost?.toStringAsFixed(2) ?? 0.0} ${'egp'.tr}",
                            subtitle: "total_cost".tr,
                            assetName: Res.totalCostIcon,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: AppText(
                        text: "stop_message".tr,
                        color: context.kHintTextColor,
                        centerText: true,
                        maxLines: 2,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      child: ElevatedButton(
                        onPressed: () {
                          showAppModalBottomSheet(
                            context: context,
                            child: StopChargingView(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.kErrorColor,
                          padding:
                              EdgeInsets.symmetric(vertical: kButtonHeight),
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
            );
          }),
    );
  }
}
