import 'package:megaplug/config/clients/storage/storage_client.dart';

class ChargingHistoryModel {
  ChargingHistoryModel({
    this.id,
    this.transactionId,
    this.chargingPointId,
    this.connectorId,
    this.userId,
    this.overallCost,
    this.energyConsumed,
    this.duration,
    this.soc,
    this.loyaltyPoints,
    this.isFinished,
    this.startedAt,
    this.finishedAt,
    this.createdAt,
    this.updatedAt,
    this.connector,
    this.chargingPoint,
  });

  ChargingHistoryModel.fromJson(dynamic json) {
    id = json['id'];
    transactionId = json['transaction_id'];
    chargingPointId = json['charging_point_id'];
    connectorId = json['connector_id'];
    userId = json['user_id'];
    overallCost = json['overall_cost'];
    energyConsumed = json['energy_consumed'];
    duration = json['duration'];
    soc = json['soc'];
    loyaltyPoints = json['loyalty_points'];
    isFinished = json['is_finished'];
    startedAt = json['started_at'];
    finishedAt = json['finished_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    connector = json['connector'] != null ? Connector.fromJson(json['connector']) : null;
    chargingPoint = json['charging_point'] != null ? ChargingPoint.fromJson(json['charging_point']) : null;
  }

  num? id;
  String? transactionId;
  num? chargingPointId;
  num? connectorId;
  num? userId;
  String? overallCost;
  String? energyConsumed;
  num? duration;
  dynamic soc;
  num? loyaltyPoints;
  bool? isFinished;
  String? startedAt;
  dynamic finishedAt;
  String? createdAt;
  String? updatedAt;
  Connector? connector;
  ChargingPoint? chargingPoint;

  ChargingHistoryModel copyWith({
    num? id,
    String? transactionId,
    num? chargingPointId,
    num? connectorId,
    num? userId,
    String? overallCost,
    String? energyConsumed,
    num? duration,
    dynamic soc,
    num? loyaltyPoints,
    bool? isFinished,
    String? startedAt,
    dynamic finishedAt,
    String? createdAt,
    String? updatedAt,
    Connector? connector,
    ChargingPoint? chargingPoint,
  }) =>
      ChargingHistoryModel(
        id: id ?? this.id,
        transactionId: transactionId ?? this.transactionId,
        chargingPointId: chargingPointId ?? this.chargingPointId,
        connectorId: connectorId ?? this.connectorId,
        userId: userId ?? this.userId,
        overallCost: overallCost ?? this.overallCost,
        energyConsumed: energyConsumed ?? this.energyConsumed,
        duration: duration ?? this.duration,
        soc: soc ?? this.soc,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        isFinished: isFinished ?? this.isFinished,
        startedAt: startedAt ?? this.startedAt,
        finishedAt: finishedAt ?? this.finishedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        connector: connector ?? this.connector,
        chargingPoint: chargingPoint ?? this.chargingPoint,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['transaction_id'] = transactionId;
    map['charging_point_id'] = chargingPointId;
    map['connector_id'] = connectorId;
    map['user_id'] = userId;
    map['overall_cost'] = overallCost;
    map['energy_consumed'] = energyConsumed;
    map['duration'] = duration;
    map['soc'] = soc;
    map['loyalty_points'] = loyaltyPoints;
    map['is_finished'] = isFinished;
    map['started_at'] = startedAt;
    map['finished_at'] = finishedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (connector != null) {
      map['connector'] = connector?.toJson();
    }
    if (chargingPoint != null) {
      map['charging_point'] = chargingPoint?.toJson();
    }
    return map;
  }
}

class ChargingPoint {
  ChargingPoint({
    this.id,
    this.serial,
    this.vendor,
    this.firmware,
    this.model,
    this.stationId,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.station,
  });

  ChargingPoint.fromJson(dynamic json) {
    id = json['id'];
    serial = json['serial'];
    vendor = json['vendor'];
    firmware = json['firmware'];
    model = json['model'];
    stationId = json['station_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    station = json['station'] != null ? Station.fromJson(json['station']) : null;
  }

  num? id;
  String? serial;
  String? vendor;
  String? firmware;
  String? model;
  num? stationId;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Station? station;

  ChargingPoint copyWith({
    num? id,
    String? serial,
    String? vendor,
    String? firmware,
    String? model,
    num? stationId,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Station? station,
  }) =>
      ChargingPoint(
        id: id ?? this.id,
        serial: serial ?? this.serial,
        vendor: vendor ?? this.vendor,
        firmware: firmware ?? this.firmware,
        model: model ?? this.model,
        stationId: stationId ?? this.stationId,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        station: station ?? this.station,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['serial'] = serial;
    map['vendor'] = vendor;
    map['firmware'] = firmware;
    map['model'] = model;
    map['station_id'] = stationId;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (station != null) {
      map['station'] = station?.toJson();
    }
    return map;
  }
}

class Station {
  Station({
    this.id,
    this.nameEn,
    this.addressEn,
    this.image,
  });

  Station.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    addressEn = json['address_en'];
    image = json['image'];
  }

  num? id;
  String? nameEn;
  String? addressEn;
  String? image;

  Station copyWith({
    num? id,
    String? nameEn,
    String? addressEn,
    String? image,
  }) =>
      Station(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        addressEn: addressEn ?? this.addressEn,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['address_en'] = addressEn;
    map['image'] = image;
    return map;
  }
}

class Connector {
  Connector({
    this.id,
    this.connectorId,
    this.chargingPointId,
    this.connectorTypeId,
    this.chargePowerId,
    this.isActive,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.connectorType,
    this.chargePower,
  });

  Connector.fromJson(dynamic json) {
    id = json['id'];
    connectorId = json['connector_id'];
    chargingPointId = json['charging_point_id'];
    connectorTypeId = json['connector_type_id'];
    chargePowerId = json['charge_power_id'];
    isActive = json['is_active'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    connectorType = json['connector_type'] != null ? ConnectorType.fromJson(json['connector_type']) : null;
    chargePower = json['charge_power'] != null ? ChargePower.fromJson(json['charge_power']) : null;
  }

  num? id;
  String? connectorId;
  num? chargingPointId;
  num? connectorTypeId;
  num? chargePowerId;
  bool? isActive;
  num? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  ConnectorType? connectorType;
  ChargePower? chargePower;

  Connector copyWith({
    num? id,
    String? connectorId,
    num? chargingPointId,
    num? connectorTypeId,
    num? chargePowerId,
    bool? isActive,
    num? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    ConnectorType? connectorType,
    ChargePower? chargePower,
  }) =>
      Connector(
        id: id ?? this.id,
        connectorId: connectorId ?? this.connectorId,
        chargingPointId: chargingPointId ?? this.chargingPointId,
        connectorTypeId: connectorTypeId ?? this.connectorTypeId,
        chargePowerId: chargePowerId ?? this.chargePowerId,
        isActive: isActive ?? this.isActive,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        connectorType: connectorType ?? this.connectorType,
        chargePower: chargePower ?? this.chargePower,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['connector_id'] = connectorId;
    map['charging_point_id'] = chargingPointId;
    map['connector_type_id'] = connectorTypeId;
    map['charge_power_id'] = chargePowerId;
    map['is_active'] = isActive;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (connectorType != null) {
      map['connector_type'] = connectorType?.toJson();
    }
    if (chargePower != null) {
      map['charge_power'] = chargePower?.toJson();
    }
    return map;
  }
}

class ChargePower {
  ChargePower({
    this.id,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  ChargePower.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? nameEn;
  String? createdAt;
  String? updatedAt;

  ChargePower copyWith({
    num? id,
    String? nameEn,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChargePower(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}

class ConnectorType {
  ConnectorType({
    this.id,
    this.nameEn,
    this.nameAr,
    this.image,
    this.symbol,
    this.isDc,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  ConnectorType.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    symbol = json['symbol'];
    isDc = json['is_dc'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? symbol;
  bool? isDc;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  ConnectorType copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    String? image,
    String? symbol,
    bool? isDc,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      ConnectorType(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        image: image ?? this.image,
        symbol: symbol ?? this.symbol,
        isDc: isDc ?? this.isDc,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['symbol'] = symbol;
    map['is_dc'] = isDc;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr! : nameEn!;
  }
}
