import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:megaplug/data/api_responses/check_balance_response.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/api_responses/scan_qr_response.dart';

import '../../config/clients/api/api_result.dart';
import '../entities/firebase/firebase_charging_session_model.dart';

abstract class ChargeRepository {
  Future<ApiResult<ScanQrResponse>> scanQr({
    required String qrCode,
  });

  Future<ApiResult<GeneralResponse>> startCharging({
    String? connectorId,
    required String serial,
  });

  Future<ApiResult<GeneralResponse>> stopCharging({
    required String? transactionId,
    required String serial,
  });

  Future<String?> getTransactionId({
    required String serial,
    String? connectorId,
  });

  Stream<DocumentSnapshot<FirebaseChargingSessionModel>> listenToChargeSession({
    required String transactionId,
  });

  Future<ApiResult<GeneralResponse>> addReview({
    required double rating,
    required String comment,
    required String stationId,
  });

  Future<ApiResult<CheckBalanceResponse>> checkBalance();
}
