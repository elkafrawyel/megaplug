import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import '../../../../../domain/controllers/stations_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      builder: (stationsController) => Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: stationsController.myLocation ?? LatLng(0, 0),
              zoom: stationsController.cameraZoom,
            ),
            myLocationEnabled: false,
            tiltGesturesEnabled: true,
            // compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
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
            top: MediaQuery.sizeOf(context).height * 0.8,
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
          PositionedDirectional(
            end: 18,
            top: MediaQuery.sizeOf(context).height * 0.85,
            child: GestureDetector(
              onTap: () {
                stationsController.moveToMyLocations();
              },
              child: SvgPicture.asset(
                Res.myLocationIcon,
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
}
