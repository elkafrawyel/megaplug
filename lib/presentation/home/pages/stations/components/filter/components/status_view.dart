import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';

import '../../../../../../../config/clients/api/api_result.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';

class StatusView extends StatelessWidget {
  const StatusView({super.key});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = context.kSecondaryColor;
    Color unSelectedColor = Color(0xffF5F6F8);

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
                  text: 'No Connectors Found',
                ),
              ),
            ),
          ApiFailure() => Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: AppText(
                  text: 'Connectors Failed To Load',
                ),
              ),
            ),
          ApiSuccess() => Obx(
              () {
                final stationController = Get.find<StationsController>();
                return Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Wrap(
                    spacing: 12,
                    children: stationController.stationsMainFilterTypes
                        .map(
                          (stationsFilter) => GestureDetector(
                            onTap: () {
                              stationController.selectedStationsFilterType
                                  .value = stationsFilter;
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: stationsFilter ==
                                        stationController
                                            .selectedStationsFilterType.value
                                    ? selectedColor
                                    : unSelectedColor,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 12),
                                child: AppText(
                                  text: stationsFilter.value ?? '',
                                  color: stationsFilter ==
                                          stationController
                                              .selectedStationsFilterType.value
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                );
              },
            ),
        };
      },
    );
  }
}
