import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';

class ChargeController extends GetxController {
  static ChargeController get to => Get.find<ChargeController>();
  RxBool isCharging = false.obs;
  String? _transactionId;

  @override
  onInit() {
    super.onInit();
    _transactionId = getTransactionId();
    isCharging.value = _transactionId != null;
  }

  clearTransactionId() async {
    await StorageClient().save(StorageClientKeys.transactionId, null);
    _transactionId = null;
    isCharging.value = false;
  }

  Future setTransactionId(String? transId) async {
    await StorageClient().save(StorageClientKeys.transactionId, transId);
    _transactionId = transId;
    isCharging.value = true;
  }

  String? getTransactionId() {
    return StorageClient().get(StorageClientKeys.transactionId);
  }
}
