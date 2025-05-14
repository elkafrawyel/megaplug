import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/domain/entities/firebase/firebase_station_model.dart';
import 'package:megaplug/domain/entities/api/charge_power_model.dart';
import 'package:megaplug/domain/entities/api/connector_type_model.dart';
import 'package:megaplug/presentation/home/pages/stations/components/pages/components/station_card_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/transformers.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../data/api_responses/station_search_response.dart';
import '../../../../../domain/entities/api/status_filter_model.dart';
import '../../../../../widgets/app_dialog_view.dart';
import '../components/pages/map/components/custom_marker_view.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cluster_manager;

class StationsController extends GetxController with WidgetsBindingObserver {
  final StationsRepositoryImpl _stationsRepository;

  StationsController(this._stationsRepository);

  static final String stationsControllerId = 'stations_view_id';
  static final String searchViewControllerId = 'search_view_id';
  static final String filterViewControllerId = 'filer_view_id';

  // if null stream to noting
  // if empty stream to all stations
  // if not null and not empty stream to stations with ids
  List<String>? stationIds = [];

  ApiResult<StationFilterResponse> stationFilterApiResult = ApiStart();
  RxList<StatusFilterModel> statusFilterTypes = <StatusFilterModel>[].obs;
  List<FirebaseStationModel> stations = [];
  RxList<ConnectorTypeModel> connectorsList = <ConnectorTypeModel>[].obs;
  RxList<ChargePowerModel> chargePowersList = <ChargePowerModel>[].obs;
  Rx<ChargePowerModel?> selectedChargePower = Rx(null);

  bool mapView = true;
  TextEditingController searchTextEditingController = TextEditingController();
  GoogleMapController? mapController;

  Set<Marker> markers = {};

  LatLng? myLocation;

  double cameraZoom = 8;
  MapType mapType = MapType.normal;

  late cluster_manager.ClusterManager<FirebaseStationModel> clusterManager;
  FocusNode searchFocusNode = FocusNode();

  @override
  onInit() async {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    clusterManager = _initClusterManager();
    getMyPosition(loading: true).then((value) => fetchData());
  }

  StreamSubscription<QuerySnapshot<FirebaseStationModel>>? subscription;
  final idsController = BehaviorSubject<List<String>?>.seeded(null);

  _setupStream() async {
    updateStationIds(stationIds);
    subscription?.cancel();
    subscription = idsController.stream
        .distinct() // Avoid duplicate requests
        .switchMap((ids) => _stationsRepository.listenToAllStations(ids: ids))
        .listen(
      (QuerySnapshot<FirebaseStationModel> event) {
        stations = event.docs
            .map(
                (QueryDocumentSnapshot<FirebaseStationModel> doc) => doc.data())
            .toList();
        updateMarkersOnMap();
      },
      onError: _handleError,
    );
  }

  void updateStationIds(List<String>? ids) {
    idsController.add(ids);
  }

  void _handleError(dynamic error) {
    Get.snackbar('Error', 'Failed to load stations');
    AppLogger.logWithGetX('Firestore error: $error');
  }

  updateMarkersOnMap() {
    clusterManager.setItems(stations);
    clusterManager.updateMap();
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await subscription?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App is back from background (including settings)
      getMyPosition(loading: false).then((value) => fetchData());
    }
  }

  Future<void> fetchData() async {
    await getStationFilter();
  }

  cluster_manager.ClusterManager<FirebaseStationModel> _initClusterManager() {
    return cluster_manager.ClusterManager(
      [],
      _updateMarkers,
      markerBuilder: markerBuilder,
    );
  }

  Future<Marker> Function(cluster_manager.Cluster<FirebaseStationModel>)
      get markerBuilder => (cluster) async {
            return Marker(
              markerId: MarkerId(cluster.getId()),
              position: cluster.location,
              onTap: () {
                if (cluster.isMultiple) {
                  animateToPoint(cluster.location);
                } else {
                  AppLogger.log(cluster.items.first.nameEn);
                  showStationCard(cluster.items.first);
                }
              },
              icon: await CustomMarkerView(
                key: UniqueKey(),
                stationStatus: cluster.isMultiple
                    ? StationStatus.area
                    : cluster.items.first.getStationStatus(),
                count: cluster.isMultiple ? cluster.count.toString() : null,
                isDc: cluster.items.first.hasDcConnectors(),
              ).toBitmapDescriptor(
                logicalSize: const Size(200, 200),
                imageSize: const Size(400, 500),
              ),
            );
          };

  Future<void> getStationFilter() async {
    stationFilterApiResult = ApiLoading();
    update([filterViewControllerId]);
    stationFilterApiResult = await _stationsRepository.getStationFilter();

    if (stationFilterApiResult.isSuccess()) {
      StationFilterResponse stationFilterResponse =
          stationFilterApiResult.getData();
      statusFilterTypes.value = stationFilterResponse.data?.statusFilters ?? [];
      statusFilterTypes.insert(
        0,
        StatusFilterModel(
          key: 'ALL',
          value: 'all'.tr,
          isSelected: false,
        ),
      );
      connectorsList.value = stationFilterResponse.data?.connectorTypes ?? [];
      chargePowersList.value = stationFilterResponse.data?.chargingPowers ?? [];

      update([filterViewControllerId]);
    } else {
      InformationViewer.showErrorToast(msg: stationFilterApiResult.getError());
    }
  }

  void toggleSelectedConnector(ConnectorTypeModel connectorTypeModel) {
    int index = connectorsList.indexOf(connectorTypeModel);
    connectorsList[index].isSelected.toggle();
  }

  final allKey = 'ALL';

  void toggleSelectedStatusFilter(StatusFilterModel statusFilterModel) {
    if (statusFilterModel.key == allKey) {
      for (var statusFilterModel in statusFilterTypes) {
        statusFilterModel.isSelected.value = false;
      }
      statusFilterModel.isSelected.value = true;
      return;
    } else {
      statusFilterTypes
          .firstWhere((status) => status.key == allKey)
          .isSelected
          .value = false;
      int index = statusFilterTypes.indexOf(statusFilterModel);
      statusFilterTypes[index].isSelected.toggle();
    }
  }

  void showStationCard(FirebaseStationModel stationModel) {
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

    _setupStream();
  }

  void animateToPoint(LatLng latLng) async {
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
        CameraUpdate.newLatLngZoom(
          myLocation!,
          cameraZoom,
        ),
        duration: Duration(seconds: 2),
      );
    }
  }

  switchMapType() {
    mapType = MapType.values[(mapType.index + 1) % MapType.values.length];
    if (mapType == MapType.none) mapType = MapType.normal;
    update([stationsControllerId]);
  }

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
      _openRequestLocationServicesDialog();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _openRequestLocationDialog();
        Future.error('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _openRequestLocationDialog();
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future getMyPosition({bool loading = true}) async {
    bool isGranted = await checkLocationPermission();
    if (!isGranted) {
      return;
    }
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
    update([stationsControllerId]);
    if (loading) {
      moveToMyLocations();
    }
  }

  void _openRequestLocationServicesDialog() async {
    Get.dialog(
      AppDialogView(
        title: 'location_services'.tr,
        message: 'location_services_message'.tr,
        actionText: 'ok'.tr,
        onActionClicked: () {
          Get.back(closeOverlays: true);
          openAppSettings();
        },
      ),
      barrierDismissible: false,
    );
  }

  _openRequestLocationDialog() {
    Get.dialog(
      Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: AppDialogView(
            title: 'location_permission'.tr,
            message: 'location_permission_message'.tr,
            onActionClicked: () async {
              Get.back(closeOverlays: true);
              openAppSettings();
            },
            actionText: 'ok'.tr,
          ),
        ),
      ),
    );
  }

  toggleMapView() {
    mapView = !mapView;
    if (mapView) {
      searchFocusNode.unfocus();
    } else {
      searchFocusNode.requestFocus();
    }
    update([
      stationsControllerId,
      searchViewControllerId,
    ]);
  }

  void clearSearchBox() {
    searchTextEditingController.clear();
    update([searchViewControllerId]);
    stationIds = [];
    _setupStream();
  }

  void handleSearchText({required String text}) async {
    if (text.isEmpty) {
      stationIds = [];
      _setupStream();
      update([searchViewControllerId]);
      return;
    }
    //todo call search api to get search results with ids
    update([searchViewControllerId]);
    AppLoader.loading();
    ApiResult apiResult =
        await _stationsRepository.searchForStations(query: text);
    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      StationSearchResponse searchResponse = apiResult.getData();
      List<String> ids = searchResponse.data ?? [];
      if (ids.isEmpty) {
        //this means that there is no search result.
        await subscription?.cancel();
        stationIds = null;
        stations.clear();
        updateMarkersOnMap();
        update([stationsControllerId]);
      } else {
        stationIds = ids;
        _setupStream();
      }
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }

  void resetFilter() async {
    selectedChargePower.value = null;
    for (var status in statusFilterTypes) {
      status.isSelected.value = false;
    }
    for (var connector in connectorsList) {
      connector.isSelected.value = false;
    }
    Get.back();
    stationIds?.clear();
    _setupStream();
  }

  Future applyFilter() async {
    Get.back();
    AppLoader.loading();
    ApiResult apiResult = await _stationsRepository.filterStations(
      statusFilter:
          statusFilterTypes.where((status) => status.isSelected.value).toList(),
      connectorTypesFilter: connectorsList
          .where((connector) => connector.isSelected.value)
          .toList(),
      chargePowerFilter: selectedChargePower.value,
    );
    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      var data = apiResult.getData();
      stationIds = data?.map((e) => e.id).toList() ?? [];
      _setupStream();
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }

  String getDistance(double stationLatitude, double stationLongitude) {
    if (myLocation != null) {
      double distanceInMeters = Geolocator.distanceBetween(
        myLocation!.latitude,
        myLocation!.longitude,
        stationLatitude,
        stationLongitude,
      );
      double distanceInKm = distanceInMeters / 1000;
      return distanceInKm.toStringAsFixed(2);
    } else {
      return '0.00';
    }
  }
}
