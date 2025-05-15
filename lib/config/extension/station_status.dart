import 'package:flutter/cupertino.dart';

enum StationStatus {
  area,
  available,
  inUse,
  unavailable,
}

extension StationStatusEx on StationStatus {
  Color get color {
    switch (this) {
      case StationStatus.area:
        return Color(0xff3EBF80);
      case StationStatus.available:
        return Color(0xff3EBF80);
      case StationStatus.unavailable:
        return Color(0xffF41F52);
      case StationStatus.inUse:
        return Color(0xffE86F00);
    }
  }

  String get text {
    switch (this) {
      case StationStatus.area:
        return 'area';
      case StationStatus.available:
        return 'available';
      case StationStatus.inUse:
        return 'in_use';
      case StationStatus.unavailable:
        return 'unavailable';
    }
  }
}
