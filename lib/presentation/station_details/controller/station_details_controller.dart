import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/station_details_response.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/presentation/station_details/components/amenities_view.dart';
import 'package:megaplug/presentation/station_details/components/connectors_view.dart';
import 'package:megaplug/presentation/station_details/components/reviews_view.dart';

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
    } else {
      InformationViewer.showErrorToast(msg: stationDetailsResult.getError());
    }
    loading = false;
    update();
  }
}
