import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChargingSessionModel {
  final String? chargingPointId;
  final String? chargingPointSerialNumber;
  final num? chargingSpeed;
  final int? connectorId;
  final String? createdAt;
  final double? currentMeterValue;
  final int? currentSoC;
  final double? duration;
  final String? durationFormatted;
  final int? endSoC;
  final String? endTime;
  final num? energyDelivered;
  final bool? isActive;
  final int? latestTimestamp;
  final double? meterStart;
  final double? meterStop;
  final String? reason;
  final String? rfid;
  final double? socIncrease;
  final int? startSoC;
  final String? startTime;
  final String? stationId;
  final String? status;
  final num? overallCost;
  final int? transactionId;
  final String? updatedAt;
  final bool? isDc;
  final String? address;
  final String? name;


  const FirebaseChargingSessionModel({
    this.chargingPointId,
    this.chargingPointSerialNumber,
    this.chargingSpeed,
    this.connectorId,
    this.createdAt,
    this.currentMeterValue,
    this.currentSoC,
    this.duration,
    this.durationFormatted,
    this.endSoC,
    this.endTime,
    this.energyDelivered,
    this.isActive,
    this.latestTimestamp,
    this.meterStart,
    this.meterStop,
    this.reason,
    this.rfid,
    this.socIncrease,
    this.startSoC,
    this.startTime,
    this.stationId,
    this.status,
    this.overallCost,
    this.transactionId,
    this.updatedAt,
    this.isDc,
    this.address,
    this.name,
  });

  factory FirebaseChargingSessionModel.fromJson(Map<String, dynamic> json) {
    return FirebaseChargingSessionModel(
      chargingPointId: json['chargingPointId'] as String?,
      chargingPointSerialNumber: json['chargingPointSerialNumber'] as String?,
      chargingSpeed: (json['chargingSpeed'] as num?)?.toDouble(),
      connectorId: json['connectorId'] as int?,
      createdAt: (json['createdAt'] as Timestamp).toString(),
      currentMeterValue: (json['currentMeterValue'] as num?)?.toDouble(),
      currentSoC: json['currentSoC'] as int?,
      duration: (json['duration'] as num?)?.toDouble(),
      durationFormatted: json['durationFormatted'] as String?,
      endSoC: json['endSoC'] as int?,
      endTime: json['endTime'] as String?,
      energyDelivered: (json['energyDelivered'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
      latestTimestamp: json['latestTimestamp'] as int?,
      meterStart: (json['meterStart'] as num?)?.toDouble(),
      meterStop: (json['meterStop'] as num?)?.toDouble(),
      reason: json['reason'] as String?,
      rfid: json['rfid'] as String?,
      socIncrease: (json['socIncrease'] as num?)?.toDouble(),
      startSoC: json['startSoC'] as int?,
      startTime: json['startTime'] as String?,
      stationId: json['stationId'] as String?,
      status: json['status'] as String?,
      overallCost: json['overallCost'] as num?,
      transactionId: json['transactionId'] as int?,
      updatedAt: (json['updatedAt'] as Timestamp).toString(),
      isDc: json['is_dc'] as bool?,
      address: json['station_address_en'] as String?,
      name: json['station_name_en'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chargingPointId': chargingPointId,
      'chargingPointSerialNumber': chargingPointSerialNumber,
      'chargingSpeed': chargingSpeed,
      'connectorId': connectorId,
      'createdAt': createdAt,
      'currentMeterValue': currentMeterValue,
      'currentSoC': currentSoC,
      'duration': duration,
      'durationFormatted': durationFormatted,
      'endSoC': endSoC,
      'endTime': endTime,
      'energyDelivered': energyDelivered,
      'isActive': isActive,
      'latestTimestamp': latestTimestamp,
      'meterStart': meterStart,
      'meterStop': meterStop,
      'reason': reason,
      'rfid': rfid,
      'socIncrease': socIncrease,
      'startSoC': startSoC,
      'startTime': startTime,
      'stationId': stationId,
      'status': status,
      'overallCost': overallCost,
      'transactionId': transactionId,
      'updatedAt': updatedAt,
      'is_dc': isDc,
      'station_address_en': address,
      'station_name_en': name,
    };
  }
}
