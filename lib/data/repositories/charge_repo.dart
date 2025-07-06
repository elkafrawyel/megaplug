import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/instance_manager.dart';
import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/check_balance_response.dart';
import 'package:megaplug/data/api_responses/general_response.dart';

import 'package:megaplug/data/api_responses/scan_qr_response.dart';
import 'package:megaplug/data/repositories/profile_repo.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';
import 'package:megaplug/domain/entities/firebase/firebase_charging_session_model.dart';

import '../../config/helpers/logging_helper.dart';
import '../../domain/repositories/charge_repo.dart';

class ChargeRepositoryImpl extends ChargeRepository {
  @override
  Future<ApiResult<ScanQrResponse>> scanQr({required String qrCode}) async {
    return APIClient.instance.get(
      endPoint: '${Res.apiScanQr}?serial=$qrCode',
      fromJson: ScanQrResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GeneralResponse>> startCharging({
    String? connectorId,
    required String serial,
  }) async {
    ApiResult<UserModel> apiResult = Get.find<ProfileRepositoryImpl>().getUserProfile();
    UserModel userModel = apiResult.getData();

    return APIClient.instance.post(
      endPoint: Res.apiStartCharging,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        if (connectorId != null) 'connectorId': connectorId,
        'chargePointSerial': serial,
        'rfid': userModel.rfid,
      },
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<String?> getTransactionId({
    required String serial,
    String? connectorId,
  }) async {
    AppLogger.logWithGetX('Getting on time : : : ${DateTime.now().second}');
    String? transactionId;
    try {
      ApiResult<UserModel> apiResult = Get.find<ProfileRepositoryImpl>().getUserProfile();
      UserModel userModel = apiResult.getData();

      Query<Map<String, dynamic>> transactionIdQuery = connectorId != null
          ? firestore
              .collection("transactions")
              .where("chargingPointSerialNumber", isEqualTo: serial)
              .where("connectorId", isEqualTo: int.parse(connectorId))
              .where("rfid", isEqualTo: userModel.rfid)
              .where("isActive", isEqualTo: true)
              .orderBy("createdAt", descending: true)
              .limit(1)
          : firestore
              .collection("transactions")
              .where("chargingPointSerialNumber", isEqualTo: serial)
              .where("rfid", isEqualTo: userModel.rfid)
              .where("isActive", isEqualTo: true)
              .orderBy("createdAt", descending: true)
              .limit(1);

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await transactionIdQuery.get();
      transactionId = querySnapshot.docs.isNotEmpty ? querySnapshot.docs.first.id : null;
      return transactionId;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<DocumentSnapshot<FirebaseChargingSessionModel>> listenToChargeSession({
    required String transactionId,
  }) {
    AppLogger.logWithGetX("""\nListening to charging session : : :
                                      \nId  => $transactionId}
                                   """);

    final collection = firestore
        .collection('transactions')
        .doc(transactionId)
        .withConverter<FirebaseChargingSessionModel>(
          fromFirestore: (snap, _) => FirebaseChargingSessionModel.fromJson(snap.data()!),
          toFirestore: (chargingSession, _) => chargingSession.toJson(),
        )
        .snapshots();

    return collection;
  }

  @override
  Future<ApiResult<GeneralResponse>> stopCharging({
    required String? transactionId,
    required String serial,
  }) async {
    return APIClient.instance.post(
      endPoint: Res.apiStopCharging,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'transactionId': transactionId,
        'chargePointSerial': serial,
      },
    );
  }

  @override
  Future<ApiResult<GeneralResponse>> addReview({
    required double rating,
    required String comment,
    required String stationId,
  }) async {
    return APIClient.instance.post(
      endPoint: Res.apiAddReview,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'rating': rating,
        'review': comment,
        'station_id': stationId,
      },
    );
  }

  @override
  Future<ApiResult<CheckBalanceResponse>> checkBalance() async{
    return APIClient.instance.get(
      endPoint: Res.apiCheckBalance,
      fromJson: CheckBalanceResponse.fromJson,
    );
  }
}
