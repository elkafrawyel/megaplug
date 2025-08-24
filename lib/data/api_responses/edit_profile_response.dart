import 'package:megaplug/domain/entities/api/user_model.dart';

class EditProfileResponse {
  EditProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  EditProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  UserModel? data;

  EditProfileResponse copyWith({
    bool? success,
    String? message,
    UserModel? data,
  }) =>
      EditProfileResponse(
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
