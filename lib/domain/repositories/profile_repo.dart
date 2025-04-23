import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/domain/entities/user_model.dart';

abstract class ProfileRepository{

  Future<ApiResult<GeneralResponse>> logout();
  Future<ApiResult<UserModel>> getUserProfile();
}