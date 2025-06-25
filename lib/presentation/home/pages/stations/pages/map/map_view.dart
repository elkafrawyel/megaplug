import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../controller/stations_controller.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<StationsController>(
      id: StationsController.stationsControllerId,
      builder: (stationsController) => Stack(
        children: [
          stationsController.myLocation == null
              ? Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: 'location_permission_message'.tr,
                        maxLines: 4,
                        centerText: true,
                      ),
                      20.ph,
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          stationsController.shouldHandleResume = true;
                          openAppSettings();
                        },
                        child: AppText(
                          text: 'enable_location_permission'.tr,
                          color: context.kColorOnPrimary,
                        ),
                      ),
                    ],
                  ),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: stationsController.myLocation!,
                    zoom: stationsController.cameraZoom,
                  ),
                  tiltGesturesEnabled: true,
                  // compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapType: stationsController.mapType,
                  onTap: (position) {
                    AppLogger.log(position, level: Level.info);
                  },
                  onCameraMove: stationsController.clusterManager.onCameraMove,
                  onCameraIdle: stationsController.clusterManager.updateMap,
                  onMapCreated: stationsController.onMapCreated,
                  markers: stationsController.markers,
                ),
          PositionedDirectional(
            end: 18,
            top: MediaQuery.sizeOf(context).height * (Platform.isAndroid ? 0.75 : 0.80),
            child: GestureDetector(
              onTap: () {
                stationsController.moveToMyLocation();
              },
              child: SvgPicture.asset(
                Res.myLocationIcon,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
          PositionedDirectional(
            end: 18,
            top: MediaQuery.sizeOf(context).height * (Platform.isAndroid ? 0.80 : 0.85),
            child: GestureDetector(
              onTap: () {
                stationsController.toggleMapView();
              },
              child: SvgPicture.asset(
                Res.listIcon,
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
