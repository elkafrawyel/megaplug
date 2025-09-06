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
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  String? message;
  Data? data;

  EditProfileResponse copyWith({
    bool? success,
    String? message,
    Data? data,
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

class Data {
  Data({
    this.user,
  });

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  UserModel? user;

  Data copyWith({
    UserModel? user,
  }) =>
      Data(
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
