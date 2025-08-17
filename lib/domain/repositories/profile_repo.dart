import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/domain/entities/api/user_model.dart';

abstract class ProfileRepository {
  Future<ApiResult<GeneralResponse>> logout();

  ApiResult<UserModel> getUserProfile();

  Future<ApiResult<GeneralResponse>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  });
}
