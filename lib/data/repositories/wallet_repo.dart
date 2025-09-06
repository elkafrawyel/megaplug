import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/balance_response.dart';
import '../../config/res.dart';
import '../../domain/repositories/wallet_repo.dart';
import '../api_responses/general_response.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<ApiResult<GeneralResponse>> addBalance() async {
    return APIClient.instance.post(
      endPoint: Res.apiAddBalance,
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
  }

  @override
  Future<ApiResult<BalanceResponse>> getBalance() async {
    return APIClient.instance.get(
      endPoint: Res.apiBalance,
      fromJson: BalanceResponse.fromJson,
    );
  }
}
