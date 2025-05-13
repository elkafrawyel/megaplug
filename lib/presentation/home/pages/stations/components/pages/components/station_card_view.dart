import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/map_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/stations/controller/stations_controller.dart';
import 'package:megaplug/presentation/station_details/station_details_screen.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../../../../../domain/entities/firebase/firebase_station_model.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';

class StationCardView extends StatelessWidget {
  final FirebaseStationModel stationModel;
  final bool inMapView;

  StationCardView({
    super.key,
    required this.stationModel,
    this.inMapView = false,
  });

  final StationsController stationsController = Get.find<StationsController>();

  @override
  Widget build(BuildContext context) {
    Color statusColor = stationModel.getStationStatus().color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            elevation: inMapView ? 10 : 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                        horizontal: 8.0,
                      ),
                      child: AppNetworkImage(
                        imageUrl:
                            'https://img.freepik.com/free-vector/cartoon-style-gas-station-background_52683-79920.jpg',
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                        radius: 8,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AppText(
                              text: stationModel.getName(),
                              fontWeight: FontWeight.bold,
                              maxLines: 3,
                            ),
                          ),
                          SizedBox(height: 4),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: AppText(
                              text: stationModel.getAddress(),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(height: 8),
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                    color: statusColor,
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text: '${stationsController.getDistance(
                                      stationModel.latitude!,
                                      stationModel.longitude!,
                                    )} ${'km'.tr}',
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.power,
                                    size: 20,
                                    color: statusColor,
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text:
                                        '${stationModel.getTotalConnectors()} ${'connectors'.tr}',
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.bolt,
                                    size: 20,
                                    color: statusColor,
                                  ),
                                  SizedBox(width: 2),
                                  AppText(
                                    text:
                                        '${stationModel.getChargingPowerText()} ${'w'.tr}',
                                    fontSize: 12,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: SvgPicture.asset(
                            Res.directionsIcon,
                          ),
                          label: AppText(
                            text: 'get_directions'.tr,
                            color: context.kColorOnPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            // width, height
                            backgroundColor: Color(0xff6C7E8E),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            MapHelper.openMap(
                              stationModel.location.latitude,
                              stationModel.location.longitude,
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: SvgPicture.asset(
                            Res.connectCarIcon,
                          ),
                          label: AppText(
                            text: 'station_details'.tr,
                            color: context.kColorOnPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            // width, height
                            backgroundColor: Color(0xff3EBF80),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            // Get.to(() => StationDetailsScreen());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                10.ph,
              ],
            ),
          ),
          PositionedDirectional(
            end: 0,
            top: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(12),
                  bottomStart: Radius.circular(12),
                ),
              ),
              child: AppText(
                text: stationModel.getStationStatus().text.tr,
                color: context.kColorOnPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
