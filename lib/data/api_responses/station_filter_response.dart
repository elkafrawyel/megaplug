import 'package:megaplug/domain/entities/api/connector_type_model.dart';

import '../../domain/entities/api/charge_power_model.dart';
import '../../domain/entities/api/status_filter_model.dart';

class StationFilterResponse {
  StationFilterResponse({
    this.success,
    this.message,
    this.data,
  });

  StationFilterResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  StationFilterResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      StationFilterResponse(
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

class Data {
  Data({
    this.connectorTypes,
    this.chargingPowers,
    this.statusFilters,
  });

  Data.fromJson(dynamic json) {
    if (json['connector_types'] != null) {
      connectorTypes = [];
      json['connector_types'].forEach((v) {
        connectorTypes?.add(ConnectorTypeModel.fromJson(v));
      });
    }
    if (json['charging_powers'] != null) {
      chargingPowers = [];
      json['charging_powers'].forEach((v) {
        chargingPowers?.add(ChargePowerModel.fromJson(v));
      });
    }
    if (json['status_filters'] != null) {
      statusFilters = [];
      json['status_filters'].forEach((v) {
        statusFilters?.add(StatusFilterModel.fromJson(v));
      });
    }
  }

  List<ConnectorTypeModel>? connectorTypes;
  List<ChargePowerModel>? chargingPowers;
  List<StatusFilterModel>? statusFilters;

  Data copyWith({
    List<ConnectorTypeModel>? connectorTypes,
    List<ChargePowerModel>? chargingPowers,
    List<StatusFilterModel>? statusFilters,
  }) =>
      Data(
        connectorTypes: connectorTypes ?? this.connectorTypes,
        chargingPowers: chargingPowers ?? this.chargingPowers,
        statusFilters: statusFilters ?? this.statusFilters,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (connectorTypes != null) {
      map['connector_types'] = connectorTypes?.map((v) => v.toJson()).toList();
    }
    if (chargingPowers != null) {
      map['charging_powers'] = chargingPowers?.map((v) => v.toJson()).toList();
    }
    if (statusFilters != null) {
      map['status_filters'] = statusFilters?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



