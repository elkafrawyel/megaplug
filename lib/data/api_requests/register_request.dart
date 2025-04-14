class RegisterRequest {
  RegisterRequest({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.passwordConfirmation,
    this.language,
  });

  RegisterRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    language = json['language'];
  }

  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? language;

  RegisterRequest copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? passwordConfirmation,
    String? language,
  }) =>
      RegisterRequest(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
        language: language ?? this.language,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['password'] = password;
    map['password_confirmation'] = passwordConfirmation;
    map['language'] = language;
    return map;
  }
}
