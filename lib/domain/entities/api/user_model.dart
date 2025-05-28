class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.language,
    this.createdAt,
    this.image,
    this.rfid,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    language = json['language'];
    createdAt = json['created_at'];
    image = json['image'];
    rfid = json['rfid'];
  }

  num? id;
  String? name;
  String? email;
  String? phone;
  String? language;
  String? createdAt;
  String? image;
  String? rfid;

  UserModel copyWith({
    num? id,
    String? name,
    String? email,
    String? phone,
    String? language,
    String? createdAt,
    String? image,
    String? rfid,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        image: image ?? this.image,
        rfid: rfid ?? this.rfid,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['language'] = language;
    map['created_at'] = createdAt;
    map['image'] = image;
    map['rfid'] = rfid;
    return map;
  }
}
