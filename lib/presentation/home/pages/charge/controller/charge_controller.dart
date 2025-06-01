import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/api_responses/scan_qr_response.dart';
import 'package:megaplug/data/repositories/charge_repo.dart';
import 'package:megaplug/domain/entities/firebase/firebase_charging_session_model.dart';
import 'package:megaplug/presentation/charging_session_summery/charging_session_summery_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../config/information_viewer.dart';
import '../../../../charging_session/charging_session_screen.dart';
import '../../../controller/home_controller.dart';

class ChargeController extends GetxController {
  final ChargeRepositoryImpl _chargeRepositoryImpl;

  static ChargeController get to => Get.find<ChargeController>();

  static const String chargingSessionControllerId =
      'chargingSessionControllerId';

  RxBool isCharging = false.obs;
  String? _transactionId;
  String? _serial;
  String? _connectorId;
  ApiResult<GeneralResponse> _swipeApiResult = ApiStart();

  ApiResult<GeneralResponse> get swipeApiResult => _swipeApiResult;

  set swipeApiResult(ApiResult<GeneralResponse> value) {
    _swipeApiResult = value;
    update();
  }

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
    isCharging.value = false;
    _serial = null;
    _connectorId = null;
  }

  Future scanQr(String serial) async {
    scanQrApiResult = ApiLoading();
    scanQrApiResult = await _chargeRepositoryImpl.scanQr(qrCode: serial);
    if (scanQrApiResult.isSuccess()) {
      _serial = serial;
      _connectorId = scanQrApiResult.getData().data?.connector?.id?.toString();
    }
  }

  Future stopCharge() async {
    if (chargingSessionModel?.chargingPointSerialNumber == null ||
        chargingSessionModel?.transactionId == null) {
      return;
    }
    AppLoader.loading();
    ApiResult apiResult = await _chargeRepositoryImpl.stopCharging(
      transactionId: chargingSessionModel!.transactionId!.toString(),
      serial: chargingSessionModel!.chargingPointSerialNumber!,
    );
    AppLoader.dismiss();
    Get.back();
    if (apiResult.isSuccess()) {
      GeneralResponse generalResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      if (chargingSessionModel != null) {
        Get.to(
          () => ChargingSessionSummeryScreen(
            chargingModel: chargingSessionModel!,
          ),
        );
      }
    } else {
      InformationViewer.showErrorToast(
        msg: apiResult.getError(),
      );
    }
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
        Duration(seconds: 5),
      );
      String? transactionId = await _chargeRepositoryImpl.getTransactionId(
        serial: _serial!,
        connectorId: _connectorId,
      );
      AppLoader.dismiss();
      Get.back();
      if (transactionId == null) {
        InformationViewer.showErrorToast(
            msg: StorageClient().isAr()
                ? 'حدث خطأ ما بدأ عملية الشحن'
                : 'An error occurred while starting the charging process');
        throw Exception(
            'Transaction ID is null, cannot proceed to charging session');
      } else {
        AppLogger.logWithGetX('Transaction ID: $transactionId');
        await Get.to(
          () => ChargingSessionScreen(
            transactionId: transactionId,
          ),
        );
        HomeController.to.handleSelectedIndex(0);
      }
    } else {
      AppLoader.dismiss();
      InformationViewer.showErrorToast(
        msg: swipeApiResult.getError(),
      );
    }
  }

  StreamSubscription<DocumentSnapshot<FirebaseChargingSessionModel>>?
      subscription;
  final transactionIdController = BehaviorSubject<String?>.seeded(null);

  FirebaseChargingSessionModel? chargingSessionModel;

  Future setTransactionId(String? transId) async {
    if (transId == null) {
      return;
    }
    await StorageClient().save(StorageClientKeys.transactionId, transId);
    _transactionId = transId;
    isCharging.value = true;
    transactionIdController.add(transId);
    // Firebase call
    subscription = transactionIdController.stream
        .distinct() // Avoid duplicate requests
        .switchMap(
          (ids) => _chargeRepositoryImpl.listenToChargeSession(
            transactionId: _transactionId!,
          ),
        )
        .listen(
      (DocumentSnapshot<FirebaseChargingSessionModel> event) {
        chargingSessionModel = event.data();
        if (chargingSessionModel == null) {
          return;
        }
        if (chargingSessionModel?.status == 'Charging') {
          update([chargingSessionControllerId]);
        } else {
          // Finished
          Get.to(
            () => ChargingSessionSummeryScreen(
              chargingModel: chargingSessionModel!,
            ),
          );
          stopSubscription();
        }
      },
      onError: _handleError,
    );
  }

  stopSubscription()async{
    if (subscription != null) {
      await subscription!.cancel();
      subscription = null;
    }
    transactionIdController.add(null);
    chargingSessionModel = null;
    await clearTransactionId();
  }

  void _handleError(dynamic error) {
    InformationViewer.showErrorToast(msg: 'Failed to load charging session');
    AppLogger.logWithGetX('Firestore error: $error');
  }

  String? getTransactionId() {
    return StorageClient().get(StorageClientKeys.transactionId);
  }
}
