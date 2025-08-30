import 'dart:io';

import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/edit_profile_response.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';

abstract class ProfileRepository {
  Future<ApiResult<GeneralResponse>> logout();

  Future<ApiResult<GeneralResponse>> deleteAccount({String? reason});

  ApiResult<UserModel> getUserProfile();

  Future<ApiResult<GeneralResponse>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });

  Future<ApiResult<EditProfileResponse>> editProfile({
    String? name,
    String? email,
    String? phone,
    File? profileImage,
  });
}
