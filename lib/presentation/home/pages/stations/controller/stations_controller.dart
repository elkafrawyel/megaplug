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
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/station_filter_response.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';
import 'package:megaplug/domain/entities/firebase/firebase_station_model.dart';
import 'package:megaplug/domain/entities/api/charge_power_model.dart';
import 'package:megaplug/domain/entities/api/connector_type_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/transformers.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../data/api_responses/station_search_response.dart';
import '../../../../../data/api_responses/stations_filter_result_response.dart';
import '../../../../../domain/entities/api/status_filter_model.dart';
import '../../../../../widgets/app_dialog_view.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cluster_manager;

import '../pages/components/station_card_view.dart';
import '../pages/map/components/custom_marker_view.dart';

class StationsController extends GetxController with WidgetsBindingObserver {
  final StationsRepositoryImpl _stationsRepository;

  StationsController(this._stationsRepository);

  //============================ Constants ==========================================
  static final String stationsControllerId = 'stations_view_id';
  static final String searchViewControllerId = 'search_view_id';
  static final String filterViewControllerId = 'filer_view_id';

  //============================ Map ===========================================
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  bool mapView = true;
  LatLng? myLocation;
  double cameraZoom = 8;
  MapType mapType = MapType.normal;
  late cluster_manager.ClusterManager<FirebaseStationModel> clusterManager;

  //============================ Stations ======================================
  // if null stream to noting
  // if empty stream to all stations
  // if not null and not empty stream to stations with ids
  List<FirebaseStationModel> stations = [];
  StreamSubscription<QuerySnapshot<FirebaseStationModel>>? subscription;
  final idsController = BehaviorSubject<List<String>?>.seeded(null);

  //============================ Filter ========================================
  ApiResult<StationFilterResponse> stationFilterApiResult = ApiStart();
  RxList<StatusFilterModel> statusFilterTypes = <StatusFilterModel>[].obs;
  RxList<ConnectorTypeModel> connectorsList = <ConnectorTypeModel>[].obs;
  RxList<ChargePowerModel> chargePowersList = <ChargePowerModel>[].obs;
  Rx<ChargePowerModel?> selectedChargePower = Rx(null);
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchTextEditingController = TextEditingController();

  final allKey = 'ALL';

  //============================================================================

  @override
  onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    clusterManager = _initClusterManager();
    getMyPosition(loading: true);
    getStationFilter();
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
      getMyPosition(loading: false);
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    AppLogger.log('onMapCreated');
    mapController = controller;
    await clusterManager.setMapId(controller.mapId);
    _setupStream();
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

  _setupStream({
    List<String> idsList = const [],
  }) async {
    _updateStationIds(idsList);
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
        _updateMarkersOnMap();
      },
      onError: _handleError,
    );
  }

  _emptyStationsList() async {
    // there is no need to listen for any thing we will just show an empty view.
    await subscription?.cancel();
    stations.clear();
    // clear markers as well as there is no stations
    _updateMarkersOnMap();
    update([stationsControllerId]);
  }

  _reloadStationsList() async {
    _setupStream();
  }

  void _updateStationIds(List<String>? ids) {
    idsController.add(ids);
  }

  void _handleError(dynamic error) {
    InformationViewer.showErrorToast(msg: 'Failed to load stations');
    AppLogger.logWithGetX('Firestore error: $error');
  }

  _updateMarkersOnMap() {
    clusterManager.setItems(stations);
    clusterManager.updateMap();
  }

  //============================  Fetching data ========================================
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

  void handleSearchText({required String text}) async {
    //this this for clear button on search bar to manage its visibility
    update([searchViewControllerId]);

    if (text.isEmpty) {
      _reloadStationsList();
      return;
    }
    //todo call search api to get search results with ids
    AppLoader.loading();
    ApiResult apiResult =
        await _stationsRepository.searchForStations(query: text);
    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      StationSearchResponse searchResponse = apiResult.getData();
      List<String> ids = searchResponse.data ?? [];
      if (ids.isEmpty) {
        //this means that there is no search result.
        _emptyStationsList();
      } else {
        _setupStream(idsList: ids);
      }
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
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
      StationsFilterResultResponse response = apiResult.getData();
      List<String> idsList =
          response.data?.map((e) => e.stationId!.toString()).toList() ?? [];
      if (idsList.isEmpty) {
        //this means that there is no search result.
        _emptyStationsList();
      } else {
        _setupStream(idsList: idsList);
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
    _setupStream();
  }

  //============================ actions ========================================
  void toggleSelectedConnector(ConnectorTypeModel connectorTypeModel) {
    int index = connectorsList.indexOf(connectorTypeModel);
    connectorsList[index].isSelected.toggle();
  }

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

  void _updateMarkers(Set<Marker> markers) {
    AppLogger.log('Updated ${markers.length} markers');
    this.markers = markers;
    update([stationsControllerId]);
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

  void moveToMyLocations() {
    if (myLocation != null && mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          myLocation!,
          cameraZoom,
        ),
        duration: Duration(seconds: 2),
      );
      _updateMarkersOnMap();
    }
  }

  switchMapType() {
    mapType = MapType.values[(mapType.index + 1) % MapType.values.length];
    if (mapType == MapType.none) mapType = MapType.normal;
    update([stationsControllerId]);
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

  void showComingSoonDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("🚧 Coming Soon"),
        content: Text("We're working hard to bring you this feature."),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}
