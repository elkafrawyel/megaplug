import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_transformtion_view.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../../widgets/bottom_sheet_header.dart';
import '../../../../charging_session/charging_session_screen.dart';
import '../controller/charge_controller.dart';

class SwipeToChargeView extends StatelessWidget {
  const SwipeToChargeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChargeController>(
      builder: (chargeController) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.vertical(
            top: Radius.circular(28),
          ),
        ),
        child: switch (chargeController.stationApiResult) {
          ApiStart() => SizedBox(),
          ApiLoading() => SizedBox(
              height: MediaQuery.sizeOf(context).height / 2,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          ApiEmpty() => AppText(
              text: 'There is no station with this result',
            ),
          ApiSuccess() => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BottomSheetHeader(),
                  10.ph,
                  AppText(
                    text:
                        '${chargeController.getTransactionId()}\nChilout Madinaty (AC)',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  10.ph,
                  AppText(
                    text: 'Cairo , nasser city , 31 abas el akad',
                    color: context.kHintTextColor,
                    fontSize: 14,
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Color(0xffF5F5F5),
                        borderRadius: BorderRadius.circular(kRadius)),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
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
                      reversed: true,
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
                        await ChargeController.to.startCharge();
                        InformationViewer.showSuccessToast(
                          msg: 'Charging started successfully',
                        );
                        Get.to(() => ChargingSessionScreen());
                      },
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
          ApiFailure() => Center(
              child:
                  AppText(text: chargeController.stationApiResult.getError()),
            ),
        },
      ),
    );
  }
}
