import 'package:get/get.dart';
import 'package:megaplug/config/app_loader.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/information_viewer.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/repositories/profile_repo.dart';

import '../../../../../config/clients/storage/storage_client.dart';

class ProfileController extends GetxController {
  final ProfileRepositoryImpl _profileRepositoryImpl;

  ProfileController(this._profileRepositoryImpl);

  Future<void> logout() async {
    AppLoader.loading();

    ApiResult<GeneralResponse> apiResult =
        await _profileRepositoryImpl.logout();

    AppLoader.dismiss();
    if (apiResult.isSuccess()) {

      Get.back();

      GeneralResponse generalResponse = apiResult.getData();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      await StorageClient().signOut();
    } else {
      InformationViewer.showErrorToast(msg: apiResult.getError());
    }
  }
}
