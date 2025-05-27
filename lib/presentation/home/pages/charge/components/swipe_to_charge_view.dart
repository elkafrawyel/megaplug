import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_transformation_view.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../controller/charge_controller.dart';

class SwipeToChargeView extends StatelessWidget {
  final String serial;

  const SwipeToChargeView({
    super.key,
    required this.serial,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppText(
            text: 'Chilout Madinaty (AC)',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          10.ph,
          AppText(
            text: 'Cairo , nasser city , 31 abas el akad',
            color: context.kHintTextColor,
            fontSize: 12,
          ),
          Container(
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xffF5F5F5),
              borderRadius: BorderRadius.circular(kRadius),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Type 2',
                          fontWeight: FontWeight.w700,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: AppText(
                            text: '22 kW (AC)',
                            color: context.kHintTextColor,
                            fontSize: 12,
                          ),
                        ),
                        AppText(
                          text: '( 1.98 EGP / kW)',
                          color: context.kPrimaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ],
                    ),
                  ),
                ),
                SvgPicture.asset(Res.chargeWalletIcon),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SlideAction(
              height: 50,
              sliderButtonIconPadding: 8,
              elevation: 0,
              sliderButtonIcon: AppTransformationView(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
              ),
              text: 'Swipe To Start Charging',
              textStyle: TextStyle(fontSize: 18, color: Colors.white),
              outerColor: context.kPrimaryColor,
              innerColor: Colors.white,
              onSubmit: () async {
                // todo start charging here
                Get.back();
                ChargeController.to.swipeToConfirm(serial: serial);
              },
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
