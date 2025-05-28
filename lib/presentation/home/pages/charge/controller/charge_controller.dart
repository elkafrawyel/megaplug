import 'dart:async';

import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/api_responses/scan_qr_response.dart';
import 'package:megaplug/data/api_responses/start_charge_response.dart';
import 'package:megaplug/data/repositories/charge_repo.dart';

import '../../../../../config/information_viewer.dart';
import '../../../../charging_session/charging_session_screen.dart';
import '../../../controller/home_controller.dart';

class ChargeController extends GetxController {
  final ChargeRepositoryImpl _chargeRepositoryImpl;
  RxDouble percentage = 0.0.obs;

  static ChargeController get to => Get.find<ChargeController>();
  RxBool isCharging = false.obs;
  String? _transactionId;
  String? _serial;

  String? _connectorId;

  Timer? timer;

  ApiResult<ScanQrResponse> _scanQrApiResult = ApiStart();

  ApiResult<ScanQrResponse> get scanQrApiResult => _scanQrApiResult;

  set scanQrApiResult(ApiResult<ScanQrResponse> value) {
    _scanQrApiResult = value;
    update();
  }

  ChargeController(this._chargeRepositoryImpl);

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

  Future scanQr(String serial) async {
    scanQrApiResult = ApiLoading();
    scanQrApiResult = await _chargeRepositoryImpl.scanQr(qrCode: serial);
    if (scanQrApiResult.isSuccess()) {
      _serial = serial;
      _connectorId = scanQrApiResult.getData().data?.connector?.id?.toString();
    }
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

  ApiResult<GeneralResponse> _swipeApiResult = ApiStart();

  ApiResult<GeneralResponse> get swipeApiResult => _swipeApiResult;

  set swipeApiResult(ApiResult<GeneralResponse> value) {
    _swipeApiResult = value;
    update();
  }

  void swipeToConfirm() async {
    if (_serial == null) {
      return;
    }
    swipeApiResult = ApiLoading();

    swipeApiResult = await _chargeRepositoryImpl.startCharging(
      connectorId: _connectorId,
      serial: _serial!,
    );
    if (swipeApiResult.isSuccess()) {
      GeneralResponse generalResponse = swipeApiResult.getData();
      InformationViewer.showSuccessToast(msg: generalResponse.message);

      await Future.delayed(
        Duration(seconds: 3),
      );
      //todo get transaction id from firebase

      String transactionId = await _chargeRepositoryImpl.getTransactionId(
        serial: _serial!,
        connectorId: _connectorId,
      );
      AppLogger.logWithGetX('Transaction ID: $transactionId');
      AppLoader.dismiss();
      Get.back();
      await Get.to(
        () => ChargingSessionScreen(
          transactionId: transactionId,
        ),
      );
      HomeController.to.handleSelectedIndex(0);
    } else {
      AppLoader.dismiss();

      InformationViewer.showErrorToast(
        msg: swipeApiResult.getError(),
      );
    }
  }

  Future setTransactionId(String? transId) async {
    await StorageClient().save(StorageClientKeys.transactionId, transId);
    _transactionId = transId;
    isCharging.value = true;

    // Firebase call
    await startCharge();
  }

  String? getTransactionId() {
    return StorageClient().get(StorageClientKeys.transactionId);
  }
}
