class FirebaseConnectorTypeModel {
  final String? chargingPointId;
  final String? status;
  final String? connectorType;
  final String? id;
  final int? connectorTypeId;
  final int? connectorId;
  final String? lastStatusUpdate;
  final int? chargePower;
  final bool? isActive;

  FirebaseConnectorTypeModel({
    this.chargingPointId,
    this.status,
    this.connectorType,
    this.id,
    this.connectorTypeId,
    this.connectorId,
    this.lastStatusUpdate,
    this.chargePower,
    this.isActive,
  });

  factory FirebaseConnectorTypeModel.fromJson(dynamic json) {
    return FirebaseConnectorTypeModel(
      chargingPointId: json['charging_point_id'] as String,
      status: json['status'] as String,
      connectorType: json['connector_type'] as String,
      id: json['id'] as String,
      connectorTypeId: json['connector_type_id'] as int,
      connectorId: json['connector_id'] as int,
      lastStatusUpdate: json['last_status_update'] as String,
      chargePower: json['charge_power'] as int,
      isActive: json['is_active'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'charging_point_id': chargingPointId,
      'status': status,
      'connector_type': connectorType,
      'id': id,
      'connector_type_id': connectorTypeId,
      'connector_id': connectorId,
      'last_status_update': lastStatusUpdate,
      'charge_power': chargePower,
      'is_active': isActive,
    };
  }
}
