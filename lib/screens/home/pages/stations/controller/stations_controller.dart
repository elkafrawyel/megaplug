import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../widgets/app_dialog_view.dart';

class StationsController extends GetxController {
  bool mapView = true;
  late TextEditingController searchTextEditingController;

  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0,0);

  double cameraZoom = 12;
  MapType mapType = MapType.normal;

  @override
  onInit() {
    super.onInit();
    searchTextEditingController = TextEditingController();
    getMyPosition(loading: true);
  }

  setMapView(bool visible) {
    mapView = visible;
    update();
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void moveToMyLocations() {
    if (mapController != null) {
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
    AppLogger.log('My Location : :   ${myLocation.latitude},${myLocation.longitude}   ');
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
}
