import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseChargingSessionModel {
  final String? chargingPointId;
  final String? chargingPointSerialNumber;
  final double? chargingSpeed;
  final int? connectorId;
  final String? createdAt;
  final double? currentMeterValue;
  final int? currentSoC;
  final double? duration;
  final String? durationFormatted;
  final int? endSoC;
  final String? endTime;
  final double? energyDelivered;
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
  final int? transactionId;
  final String? updatedAt;

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
    this.transactionId,
    this.updatedAt,
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
      transactionId: json['transactionId'] as int?,
      updatedAt: (json['updatedAt'] as Timestamp).toString(),
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
      'transactionId': transactionId,
      'updatedAt': updatedAt,
    };
  }
}
