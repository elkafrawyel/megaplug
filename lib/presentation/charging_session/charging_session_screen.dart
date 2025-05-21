import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/charging_session/components/metric_cardView.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/app_text.dart';
import 'components/rounded_circle_painter.dart';

class ChargingSessionScreen extends StatelessWidget {
  const ChargingSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charging'.tr.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      AppText(
                        text: "Tesla Model X",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 6),
                      AppText(
                        text: "ChargePoint Station - Chilout Madinaty",
                        color: context.kHintTextColor,
                        fontSize: 12,
                      ),
                      5.ph,
                      AppText(
                        text: "ID#135675323",
                        color: context.kHintTextColor,
                        fontSize: 12,
                      ),
                      20.ph,
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // SizedBox(
                          //   height: 180,
                          //   width: 180,
                          //   child: CircularProgressIndicator(
                          //     value: 0.68,
                          //     strokeWidth: 20,
                          //     backgroundColor: Color(0xffF0FAF5),
                          //     valueColor: AlwaysStoppedAnimation<Color>(
                          //       Color(0xFF28C17C),
                          //     ),
                          //   ),
                          // ),
                          CustomPaint(
                            size: Size(200, 200),
                            painter: RoundedCirclePainter(
                              percentage: 0.68,
                              foregroundColor: context.kPrimaryColor,
                              backgroundColor: Color(0xffF0FAF5),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.flash_on, color: Colors.amber),
                              Text("68%",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold)),
                              Text("125 kW",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      AppText(
                        text: "Your car is being charged",
                        color: context.kSecondaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              20.ph,
              // Metrics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MetricCardView(
                      title: "54:55",
                      subtitle: "Remaining time\nfor a full charge",
                      assetName: Res.timeIcon,
                    ),
                  ),
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
              AppText(
                text:
                    "You can stop charging from app or by disconnecting charge head from your vehicle.",
                color: context.kHintTextColor,
                centerText: true,
                maxLines: 2,
              ),
              20.ph,
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF2D55),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: AppText(
                    text: "Stop Charging",
                    color: context.kColorOnPrimary,
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