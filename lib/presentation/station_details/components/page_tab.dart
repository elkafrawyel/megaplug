import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../widgets/app_widgets/app_text.dart';
import '../controller/station_details_controller.dart';

class PageTab extends StatelessWidget {
  final int index;
  final String title;

  const PageTab({super.key, required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    final stationDetailsController = StationDetailsController.to;
    bool selected = stationDetailsController.pageIndex == index;
    return InkWell(
      onTap: () {
        stationDetailsController.pageIndex = index;
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? context.kPrimaryColor : null,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              text: title.tr,
              fontWeight: FontWeight.w500,
              color: selected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
