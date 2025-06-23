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
import 'package:megaplug/presentation/home/pages/charge/components/popups/charge_wallet_view.dart';
import 'package:megaplug/widgets/app_widgets/app_modal_bottom_sheet.dart';
import 'package:megaplug/widgets/bottom_sheet_parent.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../config/information_viewer.dart';
import '../../../../charging_session/charging_session_screen.dart';
import '../../../controller/home_controller.dart';

class ChargeController extends GetxController {
  final ChargeRepositoryImpl _chargeRepositoryImpl;

  static ChargeController get to => Get.find<ChargeController>();

  static const String chargingSessionControllerId = 'chargingSessionControllerId';

  RxBool isCharging = false.obs;
  String? _transactionId;
  String? _serial;
  String? _connectorId;
  ApiResult<GeneralResponse> swipeApiResult = ApiStart();
  bool haveFailedSwipe = false;

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

  Future scanQr(String serial, {bool preparing = false}) async {
    if (!preparing) {
      scanQrApiResult = ApiLoading();
    }
    scanQrApiResult = await _chargeRepositoryImpl.scanQr(qrCode: serial);
    if (scanQrApiResult.isSuccess()) {
      _serial = serial;
      _connectorId = scanQrApiResult.getData().data?.connector?.id?.toString();
      if (_connectorId == null) {
        await Future.delayed(Duration(seconds: 4), () {
          scanQr(serial, preparing: true);
        });
      }
    }
  }

  Future stopCharge() async {
    if (chargingSessionModel?.chargingPointSerialNumber == null || chargingSessionModel?.transactionId == null) {
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
      // if (chargingSessionModel != null) {
      //   await Get.to(
      //     () => ChargingSessionSummeryScreen(
      //       chargingModel: chargingSessionModel!,
      //     ),
      //   );
      //   Get.until((route) => route.settings.name == '/HomeScreen');
      // }
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
    update();

    swipeApiResult = await _chargeRepositoryImpl.startCharging(
      connectorId: _connectorId,
      serial: _serial!,
    );
    if (swipeApiResult.isSuccess()) {
      // GeneralResponse generalResponse = swipeApiResult.getData();
      // InformationViewer.showSuccessToast(msg: generalResponse.message);
      await Future.delayed(
        Duration(seconds: 10),
      );
      String? transactionId = await _chargeRepositoryImpl.getTransactionId(
        serial: _serial!,
        connectorId: _connectorId,
      );

      if (transactionId == null) {
        String errorMessage = StorageClient().isAr() ? 'حدث خطأ ما بدأ عملية الشحن' : 'An error occurred while starting the charging process';
        InformationViewer.showErrorToast(msg: errorMessage);
        swipeApiResult = ApiFailure(errorMessage);
        haveFailedSwipe = true;
        update();
        throw Exception('Transaction ID is null, cannot proceed to charging session');
      } else {
        AppLogger.logWithGetX('Transaction ID: $transactionId');
        Get.back();
        haveFailedSwipe = false;
        update();
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
      haveFailedSwipe = true;
      update();
    }
  }

  StreamSubscription<DocumentSnapshot<FirebaseChargingSessionModel>>? subscription;
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
      (DocumentSnapshot<FirebaseChargingSessionModel> event) async {
        chargingSessionModel = event.data();

        if (chargingSessionModel != null) {
          update([chargingSessionControllerId]);
          if (chargingSessionModel!.status == 'Charging') {
            getSessionTimer();
          } else {
            // Finished
            stopSubscription();
            await Get.to(
              () => ChargingSessionSummeryScreen(
                chargingModel: event.data()!,
              ),
            );
            Get.until((route) => route.settings.name == '/HomeScreen');
          }
        }
      },
      onError: _handleError,
    );
  }

  stopSubscription() async {
    if (subscription != null) {
      transactionIdController.add(null);
      await subscription!.cancel();
      subscription = null;
    }
    stopTimer();
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

  //================== handle timer of the session =========================

  Timer? _timer;
  DateTime? startTime;
  String? elapsedTime;

  getSessionTimer() {
    if (startTime == null) {
      AppLogger.logWithGetX('Timer is starting');
      startTime = DateTime.parse(chargingSessionModel!.startTime!);
      Duration elapsed = DateTime.now().difference(startTime!);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        elapsed = DateTime.now().difference(startTime!);
        elapsedTime = formatDuration(elapsed);
        update([chargingSessionControllerId]);
      });
    }
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  stopTimer() {
    AppLogger.logWithGetX('Timer is cancelled');
    elapsedTime = null;
    startTime = null;
    _timer?.cancel();
    _timer = null;
  }
}
