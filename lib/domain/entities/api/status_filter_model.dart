import 'package:get/get_rx/src/rx_types/rx_types.dart';

class StatusFilterModel {
  StatusFilterModel({
    this.key,
    this.value,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;

  StatusFilterModel.fromJson(dynamic json) {
    key = json['key'];
    value = json['value'];
  }

  String? key;
  String? value;

  RxBool isSelected = false.obs;


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
