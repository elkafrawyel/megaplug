import 'dart:convert';
import 'dart:io';

import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/edit_profile_response.dart';

import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';

import '../../domain/repositories/profile_repo.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ApiResult<GeneralResponse>> logout() async {
    return APIClient.instance.post(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
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

  @override
  Future<ApiResult<GeneralResponse>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    return APIClient.instance.put(
      endPoint: Res.apiChangePassword,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        "current_password": oldPassword,
        "password": newPassword,
        "password_confirmation": confirmPassword,
      },
    );
  }

  @override
  Future<ApiResult<EditProfileResponse>> editProfile({
    String? name,
    String? email,
    String? phone,
    File? profileImage,
  }) {
    return APIClient.instance.post(
      endPoint: Res.apiEditProfile,
      fromJson: EditProfileResponse.fromJson,
      requestBody: {
        "name": name,
        "email": email,
        "phone": phone,
      },
      files: profileImage == null
          ? []
          : [
              MapEntry('image', profileImage),
            ],
      forceFormData: true,
    );
  }
}
