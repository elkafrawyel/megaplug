import 'package:get/get.dart';

class ChargePowerModel {
  final String id;
  final String name;
  final double power;

  ChargePowerModel({
    required this.id,
    required this.name,
    required this.power,
    bool isSelected = false,
  });

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChargePowerModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          power == other.power;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ power.hashCode;
}
