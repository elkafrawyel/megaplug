import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import '../../../../../../../config/clients/api/api_result.dart';
import '../../../controller/stations_controller.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';

class ChargePowersView extends StatelessWidget {
  const ChargePowersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      id: StationsController.filterViewControllerId,
      builder: (stationController) {
        return switch (stationController.stationFilterApiResult) {
          ApiStart() => SizedBox(),
          ApiLoading() => CircularProgressIndicator.adaptive(),
          ApiEmpty() => Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: AppText(
                  text: 'No Charge Powers Found',
                ),
              ),
            ),
          ApiFailure() => Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: AppText(
                  text: 'Charge Powers Failed To Load',
                ),
              ),
            ),
          ApiSuccess() => Obx(
              () => Wrap(
                runSpacing: 12.0,
                spacing: 12.0,
                children: stationController.chargePowersList
                    .map(
                      (power) => GestureDetector(
                        onTap: () {
                          stationController.selectedChargePower.value = power;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                stationController.selectedChargePower.value ==
                                        power
                                    ? context.kSecondaryColor
                                    : Color(0xffF5F6F8),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 10.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  Res.lightningIcon,
                                  colorFilter: ColorFilter.mode(
                                    stationController
                                                .selectedChargePower.value ==
                                            power
                                        ? Colors.white
                                        : Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                5.pw,
                                AppText(
                                  text: power.nameEn ?? '',
                                  color: stationController
                                              .selectedChargePower.value ==
                                          power
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: stationController
                                              .selectedChargePower.value ==
                                          power
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        };
      },
    );
  }
}
