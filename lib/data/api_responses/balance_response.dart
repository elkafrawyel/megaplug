class BalanceResponse {
  BalanceResponse({
    this.success,
    this.message,
    this.data,
  });

  BalanceResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  BalanceResponse copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      BalanceResponse(
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
    this.id,
    this.balance,
    this.userName,
    this.rfid,
    this.createdAt,
    this.updatedAt,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    balance = json['balance'];
    userName = json['user_name'];
    rfid = json['rfid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? balance;
  String? userName;
  String? rfid;
  String? createdAt;
  String? updatedAt;

  Data copyWith({
    num? id,
    String? balance,
    String? userName,
    String? rfid,
    String? createdAt,
    String? updatedAt,
  }) =>
      Data(
        id: id ?? this.id,
        balance: balance ?? this.balance,
        userName: userName ?? this.userName,
        rfid: rfid ?? this.rfid,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['balance'] = balance;
    map['user_name'] = userName;
    map['rfid'] = rfid;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
