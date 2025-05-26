import 'dart:async';

import 'package:get/get.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';

class ChargeController extends GetxController {
  RxDouble percentage = 0.0.obs;

  static ChargeController get to => Get.find<ChargeController>();
  RxBool isCharging = false.obs;
  String? _transactionId;

  Timer? timer;

  ApiResult stationApiResult = ApiStart();

  @override
  onInit() {
    super.onInit();
    _transactionId = getTransactionId();
    isCharging.value = _transactionId != null;
  }

  clearTransactionId() async {
    await StorageClient().save(StorageClientKeys.transactionId, null);
    _transactionId = null;
  }

  Future setTransactionId(String? transId) async {
    stationApiResult = ApiLoading();
    update();
    await Future.delayed(Duration(seconds: 3));
    await StorageClient().save(StorageClientKeys.transactionId, transId);
    _transactionId = transId;

    //todo loadStation
    stationApiResult = ApiSuccess('');
    update();

    // isCharging.value = true;
    //
    // await startCharge();
  }

  String? getTransactionId() {
    return StorageClient().get(StorageClientKeys.transactionId);
  }

  Future startCharge() async {
    if (timer?.isActive ?? false) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (percentage.value > 1) {
        timer.cancel();
        return;
      }
      percentage.value += 0.01;
    });

    timer?.tick;
  }

  Future stopCharge() async {
    await clearTransactionId();
    isCharging.value = false;
    percentage.value = 0.0;
    timer?.cancel();
  }
}
