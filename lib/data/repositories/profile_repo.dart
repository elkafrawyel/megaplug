import 'dart:convert';

import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/res.dart';

import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';

import '../../domain/repositories/profile_repo.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ApiResult<GeneralResponse>> logout() async {
    return APIClient.instance.post(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
    );
  }

  @override
  ApiResult<UserModel> getUserProfile() {
    String? userString = StorageClient().get(StorageClientKeys.user);

    if (userString == null) {
      return ApiFailure('User not found!');
    }
    UserModel userModel = UserModel.fromJson(
      jsonDecode(userString),
    );
    return ApiSuccess(userModel);
  }
}
