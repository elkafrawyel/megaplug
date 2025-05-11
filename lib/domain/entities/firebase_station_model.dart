import 'dart:math';

import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';

import '../../config/extension/station_status.dart';

class FirebaseStationModel with ClusterItem {
  FirebaseStationModel({
    this.id,
    this.nameEn,
    this.nameAr,
    this.isActive,
    this.isOccupied,
    this.latitude,
    this.longitude,
    this.addressAr,
    this.addressEn,
    this.connectorCount,
  });

  FirebaseStationModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    isActive = json['is_active'];
    isOccupied = json['is_occupied'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    addressAr = json['address_ar'];
    addressEn = json['address_en'];
    connectorCount = json['connector_count'];
  }

  String getName() => StorageClient().isAr() ? nameAr! : nameEn!;

  String getAddress() => StorageClient().isAr() ? addressAr! : addressEn!;

  StationStatus getStationStatus() {
    if (isOccupied == true) {
      return StationStatus.busy;
    } else if (isActive == true) {
      return StationStatus.active;
    } else {
      return StationStatus.down;
    }
  }

  String? id;
  String? nameEn;
  String? addressAr;
  String? addressEn;
  String? nameAr;
  bool? isActive;
  bool? isOccupied;
  double? latitude;
  double? longitude;

  int? connectorCount;

  FirebaseStationModel copyWith({
    String? id,
    String? nameEn,
    String? nameAr,
    String? location,
    bool? isActive,
    bool? isOccupied,
    double? latitude,
    double? longitude,
    String? addressAr,
    String? addressEn,
    int? connectorCount,
  }) =>
      FirebaseStationModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        isActive: isActive ?? this.isActive,
        isOccupied: isOccupied ?? this.isOccupied,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        addressAr: addressAr ?? this.addressAr,
        addressEn: addressEn ?? this.addressEn,
        connectorCount: connectorCount ?? this.connectorCount,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['location'] = location;
    map['is_active'] = isActive;
    map['is_occupied'] = isOccupied;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['address_ar'] = addressAr;
    map['address_en'] = addressEn;
    map['connector_count'] = connectorCount;
    return map;
  }

  @override
  LatLng get location => LatLng(latitude!, longitude!);



}
