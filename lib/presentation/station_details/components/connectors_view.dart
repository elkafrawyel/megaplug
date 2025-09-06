import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/presentation/station_details/components/connector_card.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import 'station_on_map.dart';

class ConnectorsView extends StatelessWidget {
  const ConnectorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationDetailsController>(builder: (stationDetailsController) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'connector_type'.tr,
              fontWeight: FontWeight.w700,
            ),
            10.ph,
            Wrap(
              alignment: WrapAlignment.start,
              spacing: 10,
              runSpacing: 10,
              children: (stationDetailsController.stationDetailsResponse?.data?.station?.connectors ?? [])
                  .map(
                    (connector) => ConnectorCard(connector: connector),
                  )
                  .toList(),
            ),
            20.ph,
            AppText(
              text: 'location'.tr,
              fontWeight: FontWeight.w500,
            ),
            10.ph,
            StationOnMap(),
          ],
        ),
      );
    });
  }
}
