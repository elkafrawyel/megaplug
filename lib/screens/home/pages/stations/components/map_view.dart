import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/screens/home/pages/stations/controller/stations_controller.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StationsController>(
      builder: (stationsController) => Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: stationsController.myLocation,
              zoom: stationsController.cameraZoom,
            ),
            myLocationEnabled: false,
            // tiltGesturesEnabled: true,
            // compassEnabled: true,
            scrollGesturesEnabled: true,
            // zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapType: stationsController.mapType,
            onTap: (position) {
              AppLogger.log(position,level: Level.info);
            },
            onCameraMove: (position) {},
            onMapCreated: stationsController.onMapCreated,
            // markers: Set<Marker>.of(parkingController.garagesMarkersMap.values),
            // polylines: Set<Polyline>.of(parkingController.polyLinesList),
          ),
          PositionedDirectional(
            end: 18,
            bottom: 180,
            child: GestureDetector(
              onTap: () {
                stationsController.setMapView(false);
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
            bottom: 130,
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
