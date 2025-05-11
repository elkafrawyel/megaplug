import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/charge_powers_view.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/connector_types_view.dart';
import 'package:megaplug/presentation/home/pages/stations/components/filter/components/status_view.dart';
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
          top: Radius.circular(28),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.centerEnd,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF2F2F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    width: 80,
                    height: 6,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F3),
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(Res.closeIcon),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppText(
                  text: 'filter_stations'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: StatusView(),
            ),
            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppText(
                  text: 'connector_type'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ConnectorTypesView(),
            ),

            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppText(
                text: 'charge_power'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ChargePowersView(),
            ),
            30.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: context.kPrimaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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
                        backgroundColor: context.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
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
              ),
            ),
            50.ph,
          ],
        ),
      ),
    );
  }
}
