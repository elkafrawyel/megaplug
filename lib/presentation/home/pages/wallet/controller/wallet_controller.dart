import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/balance_response.dart';
import 'package:megaplug/data/repositories/wallet_repo.dart';

import '../../../../../data/api_responses/general_response.dart';

class WalletController extends GetxController {
  static WalletController get to => Get.find<WalletController>();
  final WalletRepositoryImpl _walletRepositoryImpl;

  WalletController(this._walletRepositoryImpl);

  // Add your controller logic here
  // For example, you can define variables, methods, and lifecycle methods

  ApiResult<BalanceResponse> balanceResult = ApiStart();

  @override
  void onInit() {
    super.onInit();
    _getBalance();
  }

  _getBalance({bool loading = true}) async {
    if (loading) {
      balanceResult = ApiLoading();
      update();
    }
    balanceResult = await _walletRepositoryImpl.getBalance();
    update();
  }

  Future refreshApi() async {
    _getBalance();
  }

  void addBalance() async {
    AppLoader.loading();
    ApiResult apiResult = await _walletRepositoryImpl.addBalance();
    AppLoader.dismiss();
    if (apiResult.isSuccess()) {
      GeneralResponse generalResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      _getBalance(loading: false);
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }
}
