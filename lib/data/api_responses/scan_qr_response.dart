import 'package:megaplug/config/clients/storage/storage_client.dart';

class ScanQrResponse {
  ScanQrResponse({
    this.success,
    this.message,
    this.data,
  });

  ScanQrResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? ScanQrModel.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  ScanQrModel? data;

  ScanQrResponse copyWith({
    bool? success,
    String? message,
    ScanQrModel? data,
  }) =>
      ScanQrResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class ScanQrModel {
  ScanQrModel({
    this.station,
    this.connector,
    this.balance,
  });

  ScanQrModel.fromJson(dynamic json) {
    station =
        json['station'] != null ? Station.fromJson(json['station']) : null;
    connector = json['connector'] != null
        ? Connector.fromJson(json['connector'])
        : null;
    balance = json['balance'];
  }

  Station? station;
  Connector? connector;
  String? balance;

  ScanQrModel copyWith({
    Station? station,
    Connector? connector,
    String? balance,
  }) =>
      ScanQrModel(
        station: station ?? this.station,
        connector: connector ?? this.connector,
        balance: balance ?? this.balance,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (station != null) {
      map['station'] = station?.toJson();
    }
    if (connector != null) {
      map['connector'] = connector?.toJson();
    }
    map['balance'] = balance;
    return map;
  }
}

class Connector {
  Connector({
    this.id,
    this.chargingPointId,
    this.connectorType,
    this.chargePower,
    this.isActive,
    this.status,
    this.pricePerKw,
  });

  Connector.fromJson(dynamic json) {
    id = json['id'];
    chargingPointId = json['charging_point_id'];
    connectorType = json['connector_type'] != null
        ? ConnectorType.fromJson(json['connector_type'])
        : null;
    chargePower = json['charge_power'];
    isActive = json['is_active'];
    status = json['status'];
    pricePerKw = json['price_per_kw'];
  }

  num? id;
  num? chargingPointId;
  ConnectorType? connectorType;
  String? chargePower;
  bool? isActive;
  String? status;
  String? pricePerKw;

  Connector copyWith({
    num? id,
    num? chargingPointId,
    ConnectorType? connectorType,
    String? chargePower,
    bool? isActive,
    String? status,
    String? pricePerKw,
  }) =>
      Connector(
        id: id ?? this.id,
        chargingPointId: chargingPointId ?? this.chargingPointId,
        connectorType: connectorType ?? this.connectorType,
        chargePower: chargePower ?? this.chargePower,
        isActive: isActive ?? this.isActive,
        status: status ?? this.status,
        pricePerKw: pricePerKw ?? this.pricePerKw,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['charging_point_id'] = chargingPointId;
    if (connectorType != null) {
      map['connector_type'] = connectorType?.toJson();
    }
    map['charge_power'] = chargePower;
    map['is_active'] = isActive;
    map['status'] = status;
    map['price_per_kw'] = pricePerKw;
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
  });

  ConnectorType.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = json['image'];
    symbol = json['symbol'];
    isDc = json['is_dc'];
  }

  num? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? symbol;
  bool? isDc;

  ConnectorType copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    String? image,
    String? symbol,
    bool? isDc,
  }) =>
      ConnectorType(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        image: image ?? this.image,
        symbol: symbol ?? this.symbol,
        isDc: isDc ?? this.isDc,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['image'] = image;
    map['symbol'] = symbol;
    map['is_dc'] = isDc;
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr! : nameEn!;
  }
}

class Station {
  Station({
    this.id,
    this.nameEn,
    this.nameAr,
    this.location,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.addressEn,
    this.addressAr,
  });

  Station.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    location = json['location'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressEn = json['address_en'];
    addressAr = json['address_ar'];
  }

  num? id;
  String? nameEn;
  String? nameAr;

  String? addressEn;

  String? addressAr;
  String? location;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  Station copyWith({
    num? id,
    String? nameEn,
    String? nameAr,
    String? location,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
    String? addressEn,
    String? addressAr,
  }) =>
      Station(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        nameAr: nameAr ?? this.nameAr,
        location: location ?? this.location,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        addressEn: addressEn ?? this.addressEn,
        addressAr: addressAr ?? this.addressAr,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_ar'] = nameAr;
    map['location'] = location;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['address_en'] = addressEn;
    map['address_ar'] = addressAr;
    return map;
  }

  @override
  String toString() {
    return StorageClient().isAr() ? nameAr! : nameEn!;
  }

  String? address() {
    return StorageClient().isAr() ? addressAr : addressEn;
  }
}
