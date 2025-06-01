class TransactionModel {
  TransactionModel({
    this.id,
    this.amount,
    this.type,
    this.tag,
    this.label,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  TransactionModel.fromJson(dynamic json) {
    id = json['id'];
    amount = json['amount'];
    type = json['type'];
    tag = json['tag'];
    label = json['label'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  num? id;
  String? amount;
  String? type;
  String? tag;
  String? label;
  String? description;
  String? createdAt;
  String? updatedAt;

  TransactionModel copyWith({
    num? id,
    String? amount,
    String? type,
    String? tag,
    String? label,
    String? description,
    String? createdAt,
    String? updatedAt,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        tag: tag ?? this.tag,
        label: label ?? this.label,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['amount'] = amount;
    map['type'] = type;
    map['tag'] = tag;
    map['label'] = label;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
