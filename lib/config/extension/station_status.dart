import 'package:flutter/cupertino.dart';

enum StationStatus {
  area,
  active,
  down,
  busy,
}

extension StationStatusEx on StationStatus {
  Color get color {
    switch (this) {
      case StationStatus.area:
        return Color(0xff3EBF80);
      case StationStatus.active:
        return Color(0xff3EBF80);
      case StationStatus.down:
        return Color(0xffF41F52);
      case StationStatus.busy:
        return Color(0xffE86F00);
    }
  }
}
