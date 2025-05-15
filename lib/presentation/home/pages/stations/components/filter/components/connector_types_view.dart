import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';

import '../../../../../../../config/clients/api/api_result.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../../../widgets/app_widgets/circular_checkbox.dart';

class ConnectorTypesView extends StatelessWidget {
  const ConnectorTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      id: StationsController.filterViewControllerId,
      builder: (stationController) {
        return switch (stationController.stationFilterApiResult) {
          ApiStart() => SizedBox(),
          ApiLoading() => Center(child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: CircularProgressIndicator.adaptive(),
          )),
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
              () => Column(
                children: stationController.connectorsList
                    .map(
                      (connector) => InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          stationController.toggleSelectedConnector(
                            connector,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SvgPicture.network(
                                connector.image ?? '',
                              ),
                              10.pw,
                              Expanded(
                                child: AppText(
                                  text: connector.toString(),
                                  fontSize: 13,
                                ),
                              ),
                              CircularCheckbox(
                                value: connector.isSelected.value,
                                onChanged: (bool? value) {
                                  stationController.toggleSelectedConnector(
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
            ),
        };
      },
    );
  }
}
