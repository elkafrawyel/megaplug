class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.language,
    this.avatar,
    this.rfid,
    this.loyaltyPoints,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    language = json['language'];
    avatar = json['avatar'];
    rfid = json['rfid'];
    loyaltyPoints = json['loyalty_points'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? name;
  String? email;
  String? phone;
  String? language;
  String? avatar;
  String? rfid;
  num? loyaltyPoints;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  UserModel copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? language,
    String? avatar,
    String? rfid,
    num? loyaltyPoints,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        language: language ?? this.language,
        avatar: avatar ?? this.avatar,
        rfid: rfid ?? this.rfid,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['language'] = language;
    map['avatar'] = avatar;
    map['rfid'] = rfid;
    map['loyalty_points'] = loyaltyPoints;
    map['is_active'] = isActive;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
