class ChargePowerModel {
  ChargePowerModel({
    this.id,
    this.nameEn,
    this.createdAt,
    this.updatedAt,
  });

  ChargePowerModel.fromJson(dynamic json) {
    id = json['id'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? nameEn;
  String? createdAt;
  String? updatedAt;

  ChargePowerModel copyWith({
    num? id,
    String? nameEn,
    String? createdAt,
    String? updatedAt,
  }) =>
      ChargePowerModel(
        id: id ?? this.id,
        nameEn: nameEn ?? this.nameEn,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChargePowerModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nameEn == other.nameEn &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^ nameEn.hashCode ^ createdAt.hashCode ^ updatedAt.hashCode;
}
