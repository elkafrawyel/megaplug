import 'package:get/instance_manager.dart';
import 'package:megaplug/presentation/station_details/controller/station_details_controller.dart';

class StationDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>StationDetailsController());
  }

}