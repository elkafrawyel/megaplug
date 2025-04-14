import 'package:get/get_utils/src/extensions/internacionalization.dart';

enum StationsFilterType {
  all,
  available,
  availableAndInUse,
}

extension StationType on StationsFilterType {
  String get text {
    switch (this) {
      case StationsFilterType.all:
        return 'all'.tr;
      case StationsFilterType.available:
        return 'available'.tr;
      case StationsFilterType.availableAndInUse:
        return 'available_and_in_use'.tr;
    }
  }
}
