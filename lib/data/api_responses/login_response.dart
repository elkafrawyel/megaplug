import 'user_response.dart';

class LoginResponse {
  LoginResponse({
    this.success,
    this.message,
    this.data,
  });

  LoginResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserResponse.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  UserResponse? data;

  LoginResponse copyWith({
    bool? success,
    String? message,
    UserResponse? data,
  }) =>
      LoginResponse(
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



