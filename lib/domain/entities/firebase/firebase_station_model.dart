import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/domain/entities/firebase/firebase_charging_point_model.dart';

import '../../../config/extension/station_status.dart';

class FirebaseStationModel with ClusterItem {
  FirebaseStationModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.latitude,
    this.longitude,
    this.addressAr,
    this.addressEn,
    this.status,
    this.chargingPoints = const [],
  });

  String? id;
  String? nameEn;
  String? addressAr;
  String? addressEn;
  String? nameAr;
  double? latitude;
  double? longitude;
  String? status;
  List<FirebaseChargingPointModel>? chargingPoints;

  FirebaseStationModel copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    String? location,
    double? latitude,
    double? longitude,
    String? addressAr,
    String? addressEn,
    String? status,
    List<FirebaseChargingPointModel>? chargingPoints = const [],
  }) =>
      FirebaseStationModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        addressAr: addressAr ?? this.addressAr,
        addressEn: addressEn ?? this.addressEn,
        status: status ?? this.status,
        chargingPoints: chargingPoints ?? this.chargingPoints,
      );

  factory FirebaseStationModel.fromJson(dynamic json) {
    final chargingPointsMap =
        json['charging_points'] as Map<String, dynamic>? ?? {};
    final chargingPoints = chargingPointsMap.entries.map((e) {
      final data = Map<String, dynamic>.from(e.value);
      return FirebaseChargingPointModel.fromJson(data);
    }).toList();

    return FirebaseStationModel(
      id: json['id'],
      nameEn: json['name_en'],
      nameAr: json['name_ar'],
      addressEn: json['address_en'],
      addressAr: json['address_ar'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
      chargingPoints: chargingPoints,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_en': nameEn,
        'name_ar': nameAr,
        'address_en': addressEn,
        'address_ar': addressAr,
        'latitude': latitude,
        'longitude': longitude,
        'status': status,
        'charging_points': {
          for (var cp in chargingPoints!) cp.serial: cp.toJson(),
        },
      };

  @override
  LatLng get location => LatLng(latitude!, longitude!);

  String getName() => StorageClient().isAr() ? nameAr! : nameEn!;

  String getAddress() => StorageClient().isAr() ? addressAr! : addressEn!;

  int getTotalConnectors() {
    return (chargingPoints ?? []).fold(
      0,
      (sum, cp) => sum + cp.connectors!.length.toInt(),
    );
  }

  String getChargingPowerText() {
    final powers = (chargingPoints ?? [])
        .expand((cp) => cp.connectors ?? [])
        .map((connector) => connector.chargePower)
        .toSet() // remove duplicates
        .toList()
      ..sort(); // optional: sort numerically

    return powers.join('-');
  }

  final _active = 'ACTIVE';
  final _inUse = 'IN_USE';
  final _down = 'DOWN';

  StationStatus getStationStatus() {
    if (status == _inUse) {
      return StationStatus.busy;
    } else if (status == _active) {
      return StationStatus.active;
    } else if (status == _down) {
      return StationStatus.down;
    } else {
      return StationStatus.area;
    }
  }
}
