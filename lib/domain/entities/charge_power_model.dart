import 'package:get/get.dart';

class ChargePowerModel {
  final String id;
  final String name;
  final double power;
  RxBool isSelected;

  ChargePowerModel({
    required this.id,
    required this.name,
    required this.power,
    bool isSelected = false,
  }) : isSelected = isSelected.obs;

  factory ChargePowerModel.fromJson(Map<String, dynamic> json) {
    return ChargePowerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      power: (json['power'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'power': power,
    };
  }
}
