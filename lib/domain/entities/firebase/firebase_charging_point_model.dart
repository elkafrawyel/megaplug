import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/domain/entities/firebase/firebase_connector_type_model.dart';

class FirebaseChargingPointModel {
  final dynamic id;
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

  factory FirebaseChargingPointModel.fromJson(dynamic json) {
    var connectors = <FirebaseConnectorTypeModel>[];
    try {
      final connectorsMap = json['connectors'] as Map<String, dynamic>? ?? {};
      connectors = connectorsMap.entries.map((e) {
        final data = Map<String, dynamic>.from(e.value);
        return FirebaseConnectorTypeModel.fromJson(data);
      }).toList();
    } catch (e) {
      // Handle the case where 'connectors' is not present or is malformed
      connectors = <FirebaseConnectorTypeModel>[];
      AppLogger.logWithGetX('Error parsing connectors: $e');
    }

    return FirebaseChargingPointModel(
      id: json['id'],
      serial: json['serial'],
      meterSerial: json['meter_serial'],
      meterType: json['meter_type'],
      model: json['model'],
      vendor: json['vendor'],
      stationId: json['station_id'],
      isActive: json['is_active'],
      connectors: connectors,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'serial': serial,
        'meter_serial': meterSerial,
        'meter_type': meterType,
        'model': model,
        'vendor': vendor,
        'station_id': stationId,
        'is_active': isActive,
        'connectors': {
          for (var cp in connectors!) cp.id: cp.toJson(),
        },
      };
}
