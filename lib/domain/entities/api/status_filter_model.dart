class StatusFilterModel {
  StatusFilterModel({
    this.key,
    this.value,
  });

  StatusFilterModel.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }

  String? key;
  String? value;

  StatusFilterModel copyWith({
    String? key,
    String? value,
  }) =>
      StatusFilterModel(
        key: key ?? this.key,
        value: value ?? this.value,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = key;
    map['value'] = value;
    return map;
  }
}
