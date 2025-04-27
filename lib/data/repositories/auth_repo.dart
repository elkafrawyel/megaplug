import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';

import 'package:megaplug/data/api_requests/login_request.dart';
import 'package:megaplug/data/api_requests/register_request.dart';
import 'package:megaplug/data/api_responses/general_response.dart';

import 'package:megaplug/data/api_responses/login_response.dart';
import 'package:megaplug/data/api_responses/register_response.dart';

import '../../domain/repositories/auth_repo.dart';
import '../api_requests/reset_password_request.dart';

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

  @override
  Future<ApiResult<GeneralResponse>> forgetPassword({
    required String username,
  }) {
    return APIClient.instance.post(
      endPoint: Res.apiForgetPassword,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'username': username,
      },
    );
  }

  @override
  Future<ApiResult<GeneralResponse>> verifyOtp({
    required String otp,
    required String username,
  }) async {
    return APIClient.instance.post(
      endPoint: Res.apiVerifyOtp,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'otp': otp,
        'username': username,
      },
    );
  }

  @override
  Future<ApiResult<GeneralResponse>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  }) async {
    return APIClient.instance.post(
      endPoint: Res.apiResetPassword,
      fromJson: GeneralResponse.fromJson,
      requestBody: resetPasswordRequest.toJson(),
    );
  }
}
