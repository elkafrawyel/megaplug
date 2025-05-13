import 'package:megaplug/domain/entities/firebase/firebase_connector_type_model.dart';

class FirebaseChargingPointModel {
  final String? id;
  final String? serial;
  final String? meterSerial;
  final String? meterType;
  final String? model;
  final String? vendor;
  final String? stationId;
  final bool? isActive;
  final List<FirebaseConnectorTypeModel>? connectors;

  FirebaseChargingPointModel({
    this.id,
    this.serial,
    this.meterSerial,
    this.meterType,
    this.model,
    this.vendor,
    this.stationId,
    this.isActive,
    this.connectors,
  });

  factory FirebaseChargingPointModel.fromJson(dynamic json) =>
      FirebaseChargingPointModel(
        id: json['id'],
        serial: json['serial'],
        meterSerial: json['meter_serial'],
        meterType: json['meter_type'],
        model: json['model'],
        vendor: json['vendor'],
        stationId: json['station_id'],
        isActive: json['is_active'],
        connectors: (json['connectors'] as List?)
                ?.where((e) => e != null && e is Map<String, dynamic>)
                .map(
                  (e) => FirebaseConnectorTypeModel.fromJson(
                      e as Map<String, dynamic>),
                )
                .toList() ??
            [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'serial': serial,
        'meter_serial': meterSerial,
        'meter_type': meterType,
        'model': model,
        'vendor': vendor,
        'station_id': stationId,
        'is_active': isActive,
        'connectors': connectors?.map((e) => e.toJson()).toList(),
      };
}
