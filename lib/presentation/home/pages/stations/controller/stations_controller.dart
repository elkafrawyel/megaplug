import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/extension/station_status.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/presentation/home/pages/stations/repo/stations_repo.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../widgets/app_dialog_view.dart';
import '../components/custom_marker_view.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cluster_manager;

import '../data/place_model.dart';

class StationsController extends GetxController {
  final StationsRepository _stationsRepository;

  StationsController(this._stationsRepository);

  bool mapView = true;
  int stationMarkerWidth = 40;
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
    await getMyPosition(loading: true);

    clusterManager = _initClusterManager();
  }

  cluster_manager.ClusterManager<StationModel> _initClusterManager() {
    return cluster_manager.ClusterManager(
      [],
      _updateMarkers,
      markerBuilder: markerBuilder,
    );
  }

  Future<Marker> Function(cluster_manager.Cluster) get markerBuilder =>
      (cluster) async {
        return Marker(
          markerId: MarkerId(cluster.getId()),
          position: cluster.location,
          onTap: () {
            print(cluster.items);
            animateToArea(cluster.location);
          },
          icon: await CustomMarkerView(
            key: UniqueKey(),
            stationStatus:
                cluster.isMultiple ? StationStatus.busy : StationStatus.down,
            count: cluster.isMultiple ? cluster.count.toString() : null,
          ).toBitmapDescriptor(
            logicalSize: const Size(200, 200),
            imageSize: const Size(400, 500),
          ),
        );
      };

  void _updateMarkers(Set<Marker> markers) {
    AppLogger.log('Updated ${markers.length} markers');
    this.markers = markers;
    update();
  }

  void onMapCreated(GoogleMapController controller) async {
    AppLogger.log('onMapCreated');

    mapController = controller;
    clusterManager!.setMapId(controller.mapId);

    await updateClusterItems();
  }

  Future updateClusterItems() async {
    AppLogger.log('_initClusterManager');

    ApiResult apiResult = await _stationsRepository.getAllStations();
    List<StationModel> stations = apiResult.getData();

    clusterManager?.setItems(stations);
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
          duration: 2000.ms);
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
    update();
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
    update();
  }
}
