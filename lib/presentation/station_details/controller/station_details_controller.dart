import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/presentation/station_details/components/amenities_view.dart';
import 'package:megaplug/presentation/station_details/components/connectors_view.dart';
import 'package:megaplug/presentation/station_details/components/reviews_view.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StationDetailsController extends GetxController {
  static StationDetailsController get to => Get.find<StationDetailsController>();

  final String stationId;

  final StationsRepositoryImpl stationsRepository;

  StationDetailsResponse? stationDetailsResponse;

  StationDetailsController({
    required this.stationId,
    required this.stationsRepository,
  });

  @override
  onInit() {
    super.onInit();
    _loadStationDetails(stationId);
  }

  List<Widget> pages = [
    ConnectorsView(),
    AmenitiesView(),
    ReviewsView(),
  ];
  int _pageIndex = 0;

  int get pageIndex => _pageIndex;

  set pageIndex(int value) {
    _pageIndex = value;
    update();
  }

  bool loading = false;

  void _loadStationDetails(String stationId) async {
    loading = true;
    update();
    ApiResult<StationDetailsResponse> stationDetailsResult = await stationsRepository.getStationById(stationId: stationId);
    if (stationDetailsResult.isSuccess()) {
      stationDetailsResponse = stationDetailsResult.getData();
      location = stationDetailsResponse?.data?.station?.latLng() ?? const LatLng(0, 0);
      _addCircle();
      _addMarker();
    } else {
      InformationViewer.showErrorToast(msg: stationDetailsResult.getError());
    }
    loading = false;
    update();
  }

  final Set<Circle> circles = {};
  final Set<Marker> markers = {};
  LatLng? location;

  _addMarker() async {
    if (location == null) return;

    markers.add(
      Marker(
        markerId: MarkerId('station_id'),
        position: location!,
        anchor: Offset(0.5, 0.5), // Center of the icon
        icon: await Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ).toBitmapDescriptor(
          logicalSize: const Size(150, 150),
          imageSize: const Size(200, 200),
        ),
      ),
    );
    update();

  }

  void _addCircle() {
    if (location == null) return;
    circles.add(
      Circle(
        circleId: CircleId('cairo_circle'),
        center: location!,
        radius: 500,
        // in meters
        fillColor: Color.fromRGBO(62, 191, 128, 0.08),
        strokeColor: Colors.green,
        strokeWidth: 2,
      ),
    );
    update();

  }
}
