class TransactionModel {
  TransactionModel({
    this.id,
    this.amount,
    this.type,
    this.typeValue,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    typeValue = json['type_value'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? amount;
  String? type;
  num? typeValue;
  String? description;
  String? createdAt;
  String? updatedAt;

  TransactionModel copyWith({
    num? id,
    String? amount,
    String? type,
    num? typeValue,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        typeValue: typeValue ?? this.typeValue,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['type'] = type;
    map['type_value'] = typeValue;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
