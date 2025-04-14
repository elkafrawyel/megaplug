import '../../domain/entities/user_model.dart';

class UserResponse {
  UserResponse({
    this.user,
    this.accessToken,
    this.tokenType,
  });

  UserResponse.fromJson(dynamic json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  UserModel? user;
  String? accessToken;
  String? tokenType;

  UserResponse copyWith({
    UserModel? user,
    String? accessToken,
    String? tokenType,
  }) =>
      UserResponse(
        user: user ?? this.user,
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    map['access_token'] = accessToken;
    map['token_type'] = tokenType;
    return map;
  }
}