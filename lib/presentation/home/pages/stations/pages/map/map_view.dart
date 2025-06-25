import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
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
              ? Center(child: CircularProgressIndicator())
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
