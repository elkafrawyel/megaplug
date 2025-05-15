class StationsFilterResultResponse {
  StationsFilterResultResponse({
    this.success,
    this.message,
    this.data,
  });

  StationsFilterResultResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(StationsFilterResultModel.fromJson(v));
      });
    }
  }

  bool? success;
  String? message;
  List<StationsFilterResultModel>? data;

  StationsFilterResultResponse copyWith({
    bool? success,
    String? message,
    List<StationsFilterResultModel>? data,
  }) =>
      StationsFilterResultResponse(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StationsFilterResultModel {
  StationsFilterResultModel({
    this.stationId,
    this.status,
  });

  StationsFilterResultModel.fromJson(dynamic json) {
    stationId = json['station_id'];
    status = json['status'];
  }

  num? stationId;
  String? status;

  StationsFilterResultModel copyWith({
    num? stationId,
    String? status,
  }) =>
      StationsFilterResultModel(
        stationId: stationId ?? this.stationId,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id'] = stationId;
    map['status'] = status;
    return map;
  }
}
