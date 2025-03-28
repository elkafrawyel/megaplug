import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/presentation/home/pages/stations/components/custom_marker_view.dart';

import '../../../../../widgets/app_widgets/app_text.dart';
import '../controller/stations_controller.dart';

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
            tiltGesturesEnabled: true,
            // compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            mapType: stationsController.mapType,
            onTap: (position) {
              AppLogger.log(position, level: Level.info);
            },
            onCameraMove: (position) {},
            onMapCreated: stationsController.onMapCreated,
            markers: stationsController.markers,
          ),
          PositionedDirectional(
            end: 18,
            bottom: 180,
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
          Positioned(
            left: -100,
            child: Column(
              children: stationsController.locations
                  .map(
                    (loc) => RepaintBoundary(
                      key: loc['key'],
                      child: GestureDetector(
                        onTap: () {
                          AppLogger.log(loc['text']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Stack(
                            children: [
                              SvgPicture.asset(Res.markerIcon),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.white, width: 2),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(Res.strokeIcon),
                                        AppText(
                                          text: loc['text'],
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
