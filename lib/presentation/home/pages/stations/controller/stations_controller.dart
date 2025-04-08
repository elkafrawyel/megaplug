import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

import '../../../../../widgets/app_dialog_view.dart';
import '../components/custom_marker_view.dart';

class StationsController extends GetxController {
  bool mapView = true;
  int stationMarkerWidth = 40;
  late TextEditingController searchTextEditingController;

  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0, 0);

  double cameraZoom = 13;
  MapType mapType = MapType.normal;

  Set<Marker> markers = {};

  List<Map<String, dynamic>> locations = [];

  @override
  onInit() {
    super.onInit();
    searchTextEditingController = TextEditingController();
    getMyPosition(loading: true);
    locations = [
      {
        "id": '1',
        "lat": 30.934770387046267,
        "lng": 31.176711469888684,
        "text": "25",
      },
      {
        "id": '2',
        "lat": 30.889114139158142,
        "lng": 31.181632317602634,
        "text": "50",
      },
      {
        "id": '3',
        "lat": 30.97549914890886,
        "lng": 31.138602644205093,
        "text": "70",
      },
      {
        "id": '4',
        "lat": 31.024742684457404,
        "lng": 31.235533989965912,
        "text": "10",
      },
    ];
    addMarkers();
  }

  toggleMapView() {
    mapView = !mapView;
    update();
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void moveToMyLocations() {
    if (mapController != null) {
      // mapController!.moveCamera(
      //   CameraUpdate.newLatLng(myLocation),
      // );
      mapController!.animateCamera(
        CameraUpdate.newLatLng(myLocation),
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
        'My Location : :   ${myLocation.latitude},${myLocation.longitude}   ');
    // await _getMyAddress(myLocation);
    // await _addMyMarker();
    // await getGaragesListFromApi();
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

  void addMarkers() async {
    for (Map station in locations) {
      markers.add(
        Marker(
          markerId: MarkerId(station['lat'].toString()),
          position: LatLng(
            station['lat'],
            station['lng'],
          ),
          onTap: (){
            AppLogger.log('Count : : ${station['text']}');

          },
          icon: await CustomMarkerView(
            key: UniqueKey(),

            count: station['text'],
          ).toBitmapDescriptor(
            logicalSize: const Size(200, 200),
            imageSize: const Size(400, 500),
          ),
        ),
      );
    }

    update();
  }
}
