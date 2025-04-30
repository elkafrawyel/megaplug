import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/charge_powers_view.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/connector_types_view.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/stations_type_view.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class FilterBottomSheet extends StatelessWidget {
  final ScrollController scrollController;

  const FilterBottomSheet({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
              StationsTypeView(),
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
              ConnectorTypesView(),
              10.ph,
              Divider(
                indent: 12,
                endIndent: 12,
                thickness: 0.4,
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text: 'charge_power'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ChargePowersView(),
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
                      onPressed: () {
                        Get.find<StationsController>().resetFilter();
                      },
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
                      onPressed: () {
                        Get.find<StationsController>().applyFilter();

                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
