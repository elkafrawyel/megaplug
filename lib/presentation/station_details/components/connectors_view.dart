import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/pages/map/map_view.dart';
import 'package:megaplug/presentation/station_details/components/connector_card.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import 'station_on_map.dart';

class ConnectorsView extends StatelessWidget {
  const ConnectorsView({super.key});

  @override
  Widget build(BuildContext context) {
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
            spacing: 10,
            runSpacing: 10,
            children: [
              ConnectorCard(
                connector: 'CCS',
              ),
              ConnectorCard(
                connector: 'CHAdeMO',
              ),
              ConnectorCard(
                connector: 'Type 2',
              ),
              ConnectorCard(
                connector: 'Type 1',
              ),
            ],
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
  }
}
