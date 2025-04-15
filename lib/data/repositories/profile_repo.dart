import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';

import 'package:megaplug/data/api_responses/general_response.dart';

import '../../domain/repositories/profile_repo.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  @override
  Future<ApiResult<GeneralResponse>> logout() async {
    return APIClient.instance.post(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
    );
  }
}
