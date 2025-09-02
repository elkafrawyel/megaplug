import 'package:megaplug/config/clients/api/api_client.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';

import 'package:megaplug/data/api_responses/general_response.dart';

import '../../domain/repositories/notifications_repo.dart';
import '../api_responses/unread_notifications_count_response.dart';

class NotificationsRepositoryImpl extends NotificationsRepository {
  @override
  Future<ApiResult<UnreadNotificationsCountResponse>> getUnreadCount() async {
    return APIClient.instance.get(
      endPoint: Res.apiUnReadCountNotifications,
      fromJson: UnreadNotificationsCountResponse.fromJson,
    );
  }

  @override
  Future<ApiResult<GeneralResponse>> read({required int notificationId}) async {
    return APIClient.instance.post(
      endPoint: 'notifications/$notificationId/mark-as-read',
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
  }
}
