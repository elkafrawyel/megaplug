class LoginRequest {
  LoginRequest({
    this.username,
    this.password,
    this.fcmToken,
  });

  LoginRequest.fromJson(dynamic json) {
    username = json['username'];
    password = json['password'];
    fcmToken = json['fcm_token'];
  }

  String? username;
  String? password;
  String? fcmToken;

  LoginRequest copyWith({
    String? username,
    String? password,
    String? fcmToken,

  }) =>
      LoginRequest(
        username: username ?? this.username,
        password: password ?? this.password,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    map['fcm_token'] = fcmToken;
    return map;
  }
}
