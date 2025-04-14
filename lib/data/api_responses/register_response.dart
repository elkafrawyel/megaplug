import 'package:megaplug/data/api_responses/user_response.dart';

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.message,
    this.data,
  });

  RegisterResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserResponse.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  UserResponse? data;

  RegisterResponse copyWith({
    bool? success,
    String? message,
    UserResponse? data,
  }) =>
      RegisterResponse(
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
