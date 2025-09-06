class UserModel {
  UserModel({
    this.id,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.language,
    this.isActive,
    this.loyaltyPoints,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.rfid,
    this.deletedAt,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    language = json['language'];
    isActive = json['is_active'];
    loyaltyPoints = json['loyalty_points'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rfid = json['rfid'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  String? name;
  String? avatar;
  String? email;
  String? phone;
  String? language;
  bool? isActive;
  num? loyaltyPoints;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? rfid;
  dynamic deletedAt;

  UserModel copyWith({
    num? id,
    String? name,
    String? avatar,
    String? email,
    String? phone,
    String? language,
    bool? isActive,
    num? loyaltyPoints,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    String? rfid,
    dynamic deletedAt,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        language: language ?? this.language,
        isActive: isActive ?? this.isActive,
        loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rfid: rfid ?? this.rfid,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    map['email'] = email;
    map['phone'] = phone;
    map['language'] = language;
    map['is_active'] = isActive;
    map['loyalty_points'] = loyaltyPoints;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['rfid'] = rfid;
    map['deleted_at'] = deletedAt;
    return map;
  }
}