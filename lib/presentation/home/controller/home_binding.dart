import 'package:get/instance_manager.dart';
import 'package:megaplug/presentation/home/pages/stations/repo/stations_repo.dart';

import '../pages/profile/controller/profile_controller.dart';
import '../pages/stations/controller/stations_controller.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => StationsRepository());
    Get.lazyPut(() => StationsController(Get.find<StationsRepository>()));
    Get.lazyPut(() => ProfileController());
  }
}
