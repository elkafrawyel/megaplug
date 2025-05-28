import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/api_responses/scan_qr_response.dart';

import '../../config/clients/api/api_result.dart';

abstract class ChargeRepository {
  Future<ApiResult<ScanQrResponse>> scanQr({
    required String qrCode,
  });

  Future<ApiResult<GeneralResponse>> startCharging({
    String? connectorId,
    required String serial,
  });

  Future<String> getTransactionId({
    required String serial,
    String? connectorId,
});
}