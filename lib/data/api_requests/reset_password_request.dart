class ResetPasswordRequest {
  String otp;
  String username;
  String password;
  String confirmPassword;

  ResetPasswordRequest({
    required this.otp,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'otp': otp,
      'username': username,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }
}
