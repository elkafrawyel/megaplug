import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/general_response.dart';

abstract class ProfileRepository{

  Future<ApiResult<GeneralResponse>> logout();
}