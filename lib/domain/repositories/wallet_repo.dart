import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/balance_response.dart';
import 'package:megaplug/data/api_responses/general_response.dart';

abstract class WalletRepository{
  Future<ApiResult<GeneralResponse>> addBalance();
  Future<ApiResult<BalanceResponse>> getBalance();


}