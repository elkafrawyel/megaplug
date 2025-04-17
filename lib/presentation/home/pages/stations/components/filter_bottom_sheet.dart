import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_filter_type.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/controllers/stations_controller.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../../../widgets/app_widgets/circular_checkbox.dart';

class FilterBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const FilterBottomSheet({super.key, required this.scrollController});

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
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: SingleChildScrollView(
              controller: scrollController,
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
                  switch (stationController.connectorsApiResult) {
                    ApiStart<List<ConnectorTypeModel>>() => SizedBox(),
                    ApiLoading<List<ConnectorTypeModel>>() =>
                      CircularProgressIndicator.adaptive(),
                    ApiEmpty<List<ConnectorTypeModel>>() => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: AppText(
                            text: 'No Connectors Found',
                          ),
                        ),
                      ),
                    ApiSuccess<List<ConnectorTypeModel>>() => Column(
                        children: stationController.connectorsApiResult
                            .getData()
                            .map(
                              (connector) => GestureDetector(
                                onTap: () {
                                  stationController.toggleSelectedConnector(
                                    connector,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        connector.image,
                                      ),
                                      10.pw,
                                      Expanded(
                                          child: AppText(text: connector.text)),
                                      CircularCheckbox(
                                        value: connector.isSelected,
                                        onChanged: (bool? value) {
                                          stationController
                                              .toggleSelectedConnector(
                                            connector,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ApiFailure<List<ConnectorTypeModel>>() => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(48.0),
                          child: AppText(
                            text: 'Connectors Failed To Load',
                          ),
                        ),
                      ),
                  },
                  10.ph,
                  Divider(
                    indent: 12,
                    endIndent: 12,
                    thickness: 0.4,
                  ),
                  10.ph,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        AppText(
                          text: 'charge_power'.tr,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        AppText(
                          text:
                              '${stationController.chargePowerValue.toInt()} ${'kwh'.tr}',
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 15,
                      inactiveTrackColor: const Color(0xFFF5F6F8),
                      activeTrackColor: context.kPrimaryColor,
                      trackShape: const RoundedRectSliderTrackShape(),
                      thumbShape: const CustomThumbShape(),

                      showValueIndicator: ShowValueIndicator.always,
                      valueIndicatorColor: context.kPrimaryColor,
                      valueIndicatorTextStyle: TextStyle(fontSize: 20),
                    ),
                    child: Slider(
                      value: stationController.chargePowerValue,
                      min: stationController.minChargePower,
                      max: stationController.maxChargePower,
                      onChanged: (double value) {
                        stationController.chargePowerValue = value;
                      },
                      label: stationController.chargePowerValue.toInt().toString(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        AppText(
                          text:
                              '${stationController.minChargePower.toInt()} ${'kwh'.tr}',
                          fontSize: 12,
                        ),
                        Spacer(),
                        AppText(
                          text:
                              '${stationController.maxChargePower.toInt()} ${'kwh'.tr}',
                          fontSize: 12,
                        )
                      ],
                    ),
                  ),
                  30.ph,
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.kPrimaryColor),
                          ),
                          child: AppText(
                            text: 'reset'.tr,
                            color: context.kPrimaryColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      10.pw,
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: context.kPrimaryColor),
                          child: AppText(
                            text: 'apply'.tr,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }



}


class CustomThumbShape extends SliderComponentShape {
  const CustomThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(30, 30);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(center, 15, shadowPaint);

    final Paint thumbPaint = Paint()..color = Colors.white;
    final Paint borderPaint = Paint()
      ..color = sliderTheme.activeTrackColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    canvas.drawCircle(center, 15, thumbPaint);
    canvas.drawCircle(center, 15, borderPaint);
  }
}