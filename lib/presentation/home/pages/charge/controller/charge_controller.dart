import 'dart:async';

import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';

class ChargeController extends GetxController {
  RxDouble percentage = 0.0.obs;

  static ChargeController get to => Get.find<ChargeController>();
  RxBool isCharging = false.obs;
  String? _transactionId;

  Timer? timer;

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
    await StorageClient().save(StorageClientKeys.transactionId, transId);
    _transactionId = transId;
    isCharging.value = true;

    startCharge();
  }

  String? getTransactionId() {
    return StorageClient().get(StorageClientKeys.transactionId);
  }

  void startCharge() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (percentage.value > 1) {
        timer.cancel();
        return;
      }
      percentage.value += 0.01;
    });

    timer?.tick;
  }

  void stopCharge()async {
    await clearTransactionId();
    isCharging.value = false;
    percentage.value = 0.0;
    timer?.cancel();
  }
}
