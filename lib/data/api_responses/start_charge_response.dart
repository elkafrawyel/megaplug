class StartChargeResponse {
  StartChargeResponse({
    this.success,
    this.message,
    this.data,
  });

  StartChargeResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  StartChargeResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      StartChargeResponse(
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
    this.transactionId,
    this.status,
  });

  Data.fromJson(dynamic json) {
    transactionId = json['transactionId'];
    status = json['status'];
  }

  num? transactionId;
  String? status;

  Data copyWith({
    num? transactionId,
    String? status,
  }) =>
      Data(
        transactionId: transactionId ?? this.transactionId,
        status: status ?? this.status,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transactionId'] = transactionId;
    map['status'] = status;
    return map;
  }
}
