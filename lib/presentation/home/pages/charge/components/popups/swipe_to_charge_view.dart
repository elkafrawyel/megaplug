import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/data/api_responses/scan_qr_response.dart';
import 'package:megaplug/widgets/app_transformation_view.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../controller/charge_controller.dart';

class SwipeToChargeView extends StatelessWidget {
  const SwipeToChargeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChargeController>(builder: (chargeController) {
      final ScanQrModel? scanQrModel =
          chargeController.scanQrApiResult.getData().data;

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppText(
              text: scanQrModel?.station?.toString() ?? '',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            10.ph,
            AppText(
              text: scanQrModel?.station?.address() ?? '',
              color: context.kHintTextColor,
              fontSize: 12,
            ),
            if (chargeController.swipeApiResult.isLoading())
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Lottie.asset(
                  Res.settingUpAnimation,
                  width: 100,
                  height: 100,
                ),
              ),
            if (chargeController.swipeApiResult.isLoading())
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                child: AppText(
                  text:
                      'We’re setting things up.\nYour charging session will begin in just a moment.',
                  maxLines: 3,
                  centerText: true,
                ),
              ),
            if (scanQrModel?.connector != null &&
                chargeController.swipeApiResult.isSuccess())
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
                              text: scanQrModel?.connector?.connectorType
                                      ?.toString() ??
                                  '',
                              fontWeight: FontWeight.w700,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: AppText(
                                text:
                                    '${scanQrModel?.connector?.chargePower} (${(scanQrModel?.connector?.connectorType?.isDc ?? false) ? 'AC' : 'DC'})',
                                color: context.kHintTextColor,
                                fontSize: 12,
                              ),
                            ),
                            AppText(
                              text:
                                  '(${scanQrModel?.connector?.pricePerKw} EGP/kWh)',
                              color: context.kPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (scanQrModel?.connector?.connectorType?.symbol != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.network(
                            scanQrModel?.connector?.connectorType?.symbol ??
                                ''),
                      ),
                  ],
                ),
              ),
            chargeController.swipeApiResult.isLoading()
                ? SizedBox()
                : Padding(
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
                      text: chargeController.haveFailedSwipe
                          ? 'Swipe To Retry Charging'
                          : 'Swipe To Start Charging',
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      outerColor: context.kPrimaryColor,
                      innerColor: Colors.white,
                      onSubmit: () async {
                        ChargeController.to.swipeToConfirm();
                      },
                    ),
                  ),
            10.ph,
          ],
        ),
      );
    });
  }
}
