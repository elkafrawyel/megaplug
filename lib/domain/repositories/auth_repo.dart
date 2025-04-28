import 'package:megaplug/data/api_responses/general_response.dart';
import 'package:megaplug/data/api_responses/login_response.dart';

import '../../config/clients/api/api_result.dart';
import '../../data/api_requests/login_request.dart';
import '../../data/api_requests/register_request.dart';
import '../../data/api_requests/reset_password_request.dart';
import '../../data/api_responses/register_response.dart';

abstract class AuthRepository {
  Future<ApiResult<LoginResponse>> login({
    required LoginRequest loginRequest,
  });

  Future<ApiResult<RegisterResponse>> register({
    required RegisterRequest registerRequest,
  });

  Future<ApiResult<GeneralResponse>> forgetPassword({
    required String username,
  });

  Future<ApiResult<GeneralResponse>> verifyOtp({
    required String otp,
    required String username,
  });

  Future<ApiResult<RegisterResponse>> verifyAccount({
    required String otp,
    required String username,
  });

  Future<ApiResult<GeneralResponse>> resetPassword({
    required ResetPasswordRequest resetPasswordRequest,
  });
}
