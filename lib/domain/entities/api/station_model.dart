import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/extension/station_status.dart';

class StationModel with ClusterItem {
  final String name;
  final LatLng latLng;

  final StationStatus stationStatus;

  StationModel({
    required this.name,
    required this.latLng,
    this.stationStatus = StationStatus.available,
  });

  @override
  LatLng get location => latLng;

  @override
  String toString() {
    return name;
  }
}
