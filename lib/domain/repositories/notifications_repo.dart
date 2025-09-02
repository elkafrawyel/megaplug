import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/data/api_responses/general_response.dart';

import '../../data/api_responses/unread_notifications_count_response.dart';

abstract class NotificationsRepository {
  Future<ApiResult<UnreadNotificationsCountResponse>> getUnreadCount();

  Future<ApiResult<GeneralResponse>> read({required String notificationId});
}
