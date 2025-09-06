class CheckBalanceResponse {
  CheckBalanceResponse({
    this.success,
    this.message,
    this.data,
  });

  CheckBalanceResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? CheckBalanceModel.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  CheckBalanceModel? data;

  CheckBalanceResponse copyWith({
    bool? success,
    String? message,
    CheckBalanceModel? data,
  }) =>
      CheckBalanceResponse(
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

class CheckBalanceModel {
  CheckBalanceModel({
    this.balance,
    this.minBalance,
    this.isSufficient,
  });

  CheckBalanceModel.fromJson(dynamic json) {
    balance = json['balance'];
    minBalance = json['min_balance'];
    isSufficient = json['is_sufficient'];
  }

  String? balance;
  String? minBalance;
  bool? isSufficient;

  CheckBalanceModel copyWith({
    String? balance,
    String? minBalance,
    bool? isSufficient,
  }) =>
      CheckBalanceModel(
        balance: balance ?? this.balance,
        minBalance: minBalance ?? this.minBalance,
        isSufficient: isSufficient ?? this.isSufficient,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['balance'] = balance;
    map['min_balance'] = minBalance;
    map['is_sufficient'] = isSufficient;
    return map;
  }
}
