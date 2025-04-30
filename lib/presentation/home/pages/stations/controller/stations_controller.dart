import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/domain/entities/charge_power_model.dart';
import 'package:megaplug/domain/entities/connector_type_model.dart';
import 'package:megaplug/domain/entities/station_main_filter_type_model.dart';
import 'package:megaplug/presentation/home/pages/stations/components/pages/components/station_card_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../widgets/app_dialog_view.dart';
import '../components/pages/map/components/custom_marker_view.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cluster_manager;

import '../../../../../domain/entities/station_model.dart';

class StationsController extends GetxController {
  final StationsRepositoryImpl _stationsRepository;

  StationsController(this._stationsRepository);

  static final String stationsControllerId = 'stations_view_id';
  static final String searchViewControllerId = 'search_view_id';
  static final String filterViewControllerId = 'filer_view_id';

  ApiResult<List<StationMainFilterTypeModel>> stationMainFilterTypeApiResult =
      ApiStart();
  RxList<StationMainFilterTypeModel> stationsMainFilterTypes =
      <StationMainFilterTypeModel>[].obs;
  Rx<StationMainFilterTypeModel?> selectedStationsFilterType = Rx(null);

  List<StationModel> stations = [];

  ApiResult<List<ConnectorTypeModel>> connectorsApiResult = ApiStart();
  RxList<ConnectorTypeModel> connectorsList = <ConnectorTypeModel>[].obs;

  ApiResult<List<ChargePowerModel>> chargePowersApiResult = ApiStart();
  RxList<ChargePowerModel> chargePowersList = <ChargePowerModel>[].obs;

  bool mapView = true;
  TextEditingController searchTextEditingController = TextEditingController();
  GoogleMapController? mapController;

  Set<Marker> markers = {};

  LatLng? myLocation;

  double cameraZoom = 8;
  MapType mapType = MapType.normal;

  late cluster_manager.ClusterManager<StationModel> clusterManager;

  @override
  onInit() async {
    super.onInit();

    clusterManager = _initClusterManager();

    await getMyPosition(loading: true);

    getAllStationMainFilterType();
    getAllChargePowers();
    getAllConnectors();
  }

  cluster_manager.ClusterManager<StationModel> _initClusterManager() {
    return cluster_manager.ClusterManager(
      [],
      _updateMarkers,
      markerBuilder: markerBuilder,
    );
  }

  Future<Marker> Function(cluster_manager.Cluster<StationModel>)
      get markerBuilder => (cluster) async {
            return Marker(
              markerId: MarkerId(cluster.getId()),
              position: cluster.location,
              onTap: () {
                if (cluster.isMultiple) {
                  animateToArea(cluster.location);
                } else {
                  AppLogger.log(cluster.items.first.name);
                  showStationCard(cluster.items.first);
                }
              },
              icon: await CustomMarkerView(
                key: UniqueKey(),
                stationStatus: cluster.isMultiple
                    ? StationStatus.area
                    : cluster.items.first.stationStatus,
                count: cluster.isMultiple ? cluster.count.toString() : null,
              ).toBitmapDescriptor(
                logicalSize: const Size(150, 150),
                imageSize: const Size(400, 500),
              ),
            );
          };

  Future<void> getAllStationMainFilterType() async {
    stationMainFilterTypeApiResult = ApiLoading();
    update([filterViewControllerId]);
    stationMainFilterTypeApiResult =
        await _stationsRepository.getAllStationMainFilterTypes();
    update([filterViewControllerId]);
    stationsMainFilterTypes.value = stationMainFilterTypeApiResult.getData();
  }

  Future<void> getAllConnectors() async {
    connectorsApiResult = ApiLoading();
    update([filterViewControllerId]);
    connectorsApiResult = await _stationsRepository.getAllConnectorTypes();
    update([filterViewControllerId]);
    connectorsList.value = connectorsApiResult.getData();
  }

  Future<void> getAllChargePowers() async {
    chargePowersApiResult = ApiLoading();
    update([filterViewControllerId]);
    chargePowersApiResult = await _stationsRepository.getAllChargePowers();
    update([filterViewControllerId]);
    chargePowersList.value = chargePowersApiResult.getData();
  }

  void toggleSelectedConnector(ConnectorTypeModel connectorTypeModel) {
    int index = connectorsList.indexOf(connectorTypeModel);
    connectorsList[index].isSelected.toggle();
  }

  void toggleSelectedChargePower(ChargePowerModel chargePowerModel) {
    int index = chargePowersList.indexOf(chargePowerModel);
    chargePowersList[index].isSelected.toggle();
  }

  void showStationCard(StationModel stationModel) {
    Get.dialog(
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StationCardView(
            stationModel: stationModel,
          ),
        ),
      ),
      barrierColor: Colors.black54,
    );
  }

  void _updateMarkers(Set<Marker> markers) {
    AppLogger.log('Updated ${markers.length} markers');
    this.markers = markers;
    update([stationsControllerId]);
  }

  void onMapCreated(GoogleMapController controller) async {
    AppLogger.log('onMapCreated');

    mapController = controller;
    clusterManager.setMapId(controller.mapId);

    await updateClusterItems();
  }

  Future updateClusterItems() async {
    AppLogger.log('_initClusterManager');

    ApiResult apiResult = await _stationsRepository.getAllStations();
    stations = apiResult.getData();

    clusterManager.setItems(stations);
  }

  void animateToArea(LatLng latLng) async {
    if (mapController != null) {
      double oldZoom = await mapController!.getZoomLevel();
      mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: latLng,
              zoom: oldZoom + 2,
            ),
          ),
          duration: 1000.ms);
    }
  }

  ///==========================================================================
  void moveToMyLocations() {
    if (myLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLng(myLocation!),
      );
    }
  }

  switchMapType() {
    mapType = MapType.values[(mapType.index + 1) % MapType.values.length];
    if (mapType == MapType.none) mapType = MapType.normal;
    update([stationsControllerId]);
  }

  Future checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _openSettingDialog();
        Future.error('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _openSettingDialog();
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }

  Future getMyPosition({bool loading = true}) async {
    await checkLocationPermission();
    if (loading) {
      EasyLoading.show(status: 'getting_location'.tr);
    }
    Position position = await Geolocator.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    AppLogger.log(
        'My Location : :   ${myLocation?.latitude},${myLocation?.longitude}');
    if (loading) {
      EasyLoading.dismiss();
    }
    update();
    if (loading) {
      moveToMyLocations();
    }
  }

  _openSettingDialog() {
    Get.dialog(
      AppDialogView(
        title: 'location_permission'.tr,
        message: 'location_permission_message'.tr,
        onActionClicked: () async {
          Get.back();
          openAppSettings();
        },
        actionText: 'ok'.tr,
        // svgName: Res.iconLocation,
      ),
    );
  }

  toggleMapView() {
    mapView = !mapView;
    update([stationsControllerId]);
  }

  void clearSearchBox() {
    searchTextEditingController.clear();
    update([searchViewControllerId]);
  }

  void handleSearchText({required String text}) {
    update([searchViewControllerId]);
  }

  void resetFilter() {
    selectedStationsFilterType.value = null;
    for (var connector in connectorsList) {
      connector.isSelected.value = false;
    }

    for (var chargePower in chargePowersList) {
      chargePower.isSelected.value = false;
    }

    // todo call api to reset filter
  }

  void applyFilter() {
    Get.back();
  }
}
