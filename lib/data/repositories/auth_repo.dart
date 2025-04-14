import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';

import 'package:megaplug/data/api_requests/login_request.dart';
import 'package:megaplug/data/api_requests/register_request.dart';

import 'package:megaplug/data/api_responses/login_response.dart';
import 'package:megaplug/data/api_responses/register_response.dart';

import '../../domain/repositories/auth_repo.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<ApiResult<LoginResponse>> login({
    required LoginRequest loginRequest,
  }) async {
    return APIClient.instance.post(
      endPoint: Res.apiLogin,
      fromJson: LoginResponse.fromJson,
      requestBody: loginRequest.toJson(),
    );
  }

  @override
  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest registerRequest,
  }) {
    return APIClient.instance.post(
      endPoint: Res.apiRegister,
      fromJson: RegisterResponse.fromJson,
      requestBody: registerRequest.toJson(),
    );
  }
}
