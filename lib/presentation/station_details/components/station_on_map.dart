import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StationOnMap extends StatelessWidget {
  const StationOnMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(38),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<StationDetailsController>(
            builder: (stationDetailsController) {
              return stationDetailsController.location == null
                  ? SizedBox()
                  : GoogleMap(
                      scrollGesturesEnabled: true,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        target: stationDetailsController.location!,
                        zoom: 14,
                      ),
                      circles: stationDetailsController.circles,
                      markers: stationDetailsController.markers,
                    );
            },
          ),
        ),
      ),
    );
  }
}
