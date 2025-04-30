import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/charge_power_model.dart';

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
        return switch (stationController.chargePowersApiResult) {
          ApiStart<List<ChargePowerModel>>() => SizedBox(),
          ApiLoading<List<ChargePowerModel>>() =>
            CircularProgressIndicator.adaptive(),
          ApiEmpty<List<ChargePowerModel>>() => Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: AppText(
                  text: 'No Charge Powers Found',
                ),
              ),
            ),
          ApiFailure<List<ChargePowerModel>>() => Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: AppText(
                  text: 'Charge Powers Failed To Load',
                ),
              ),
            ),
          ApiSuccess<List<ChargePowerModel>>() => Obx(
              () => Wrap(
                runSpacing: 12.0,
                spacing: 12.0,
                children: stationController.chargePowersList
                    .map(
                      (power) => GestureDetector(
                        onTap: () {
                          stationController.toggleSelectedChargePower(
                            power,
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: power.isSelected.value
                                ? context.kSecondaryColor
                                : Color(0xffF5F6F8),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                              vertical: 8.0,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.bolt,
                                  size: 20,
                                  color: power.isSelected.value
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                AppText(
                                  text: '${power.power.toInt().toString()} ${"kwh".tr}',
                                  color: power.isSelected.value
                                      ? Colors.white
                                      : Colors.black,
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
