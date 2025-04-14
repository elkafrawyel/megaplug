class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.language,
    this.createdAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    language = json['language'];
    createdAt = json['created_at'];
  }

  num? id;
  String? name;
  String? email;
  String? phone;
  String? language;
  String? createdAt;

  UserModel copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? language,
    String? createdAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['language'] = language;
    map['created_at'] = createdAt;
    return map;
  }
}
