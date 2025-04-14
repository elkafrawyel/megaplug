import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_filter_type.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/controllers/stations_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = context.kSecondaryColor;
    Color unSelectedColor = Color(0xffF5F6F8);
    return GetBuilder<StationsController>(
        id: StationsController.filterViewControllerId,
        builder: (stationController) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF2F2F3),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: 100,
                        height: 7,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF2F2F3),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.clear),
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.ph,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText(
                      text: 'filter_stations'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  10.ph,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Wrap(
                      spacing: 12,
                      children: StationsFilterType.values
                          .map(
                            (stationsFilter) => GestureDetector(
                              onTap: () {
                                stationController.stationsFilterType =
                                    stationsFilter;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: stationsFilter ==
                                          stationController.stationsFilterType
                                      ? selectedColor
                                      : unSelectedColor,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0, vertical: 10),
                                  child: AppText(
                                    text: stationsFilter.text,
                                    color: stationsFilter ==
                                            stationController.stationsFilterType
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  20.ph,
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppText(
                      text: 'connector_type'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  10.ph,
                ],
              ),
            ),
          );
        });
  }
}
