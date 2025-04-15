import 'package:get/instance_manager.dart';
import 'package:megaplug/data/repositories/profile_repo.dart';
import 'package:megaplug/data/repositories/stations_repo.dart';

import '../pages/profile/controller/profile_controller.dart';
import '../../../domain/controllers/stations_controller.dart';
import 'home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => StationsRepositoryImpl());
    Get.lazyPut(() => StationsController(Get.find<StationsRepositoryImpl>()));

    Get.lazyPut(()=>ProfileRepositoryImpl());
    Get.lazyPut(() => ProfileController(Get.find<ProfileRepositoryImpl>()));
  }
}
