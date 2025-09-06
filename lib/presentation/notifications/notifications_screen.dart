import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/presentation/notifications/components/empty_view.dart';
import 'package:megaplug/presentation/notifications/components/notification_cardView.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/app_paginated_listview.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';

import '../../config/clients/api/api_result.dart';
import '../../data/api_responses/general_response.dart';
import '../../data/repositories/notifications_repo.dart';
import '../../domain/entities/api/notification_model.dart';
import '../home/pages/stations/controller/stations_controller.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});

  final GlobalKey<AppPaginatedListviewState> appPaginatedListviewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'notifications'.tr,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 38.0, horizontal: 8.0),
        child: AppPaginatedListview<NotificationModel>(
          key: appPaginatedListviewKey,
          child: (notificationModel) => GestureDetector(
            onTap: () {
              if (notificationModel.readAt == null) {
                // Mark notification as read
                _readNotification(notificationModel);
              }
            },
            child: NotificationCardView(notificationModel: notificationModel),
          ),
          emptyView: EmptyView(),
          configData: ConfigData(
            apiEndPoint: Res.apiNotifications,
            fromJson: NotificationModel.fromJson,
          ),
        ),
      ),
    );
  }

  void _readNotification(NotificationModel notification) async {
    ApiResult<GeneralResponse> apiResult = await NotificationsRepositoryImpl().read(
      notificationId: notification.id!,
    );
    if (apiResult.isSuccess()) {
      // Successfully marked as read
      // You can update the UI or state here if needed
      appPaginatedListviewKey.currentState?.updateSingleItem(
        notification.copyWith(
          //this will update the notification in the list to show it as read
          readAt: DateTime.now().toIso8601String(),
        ),
      );
      Get.find<StationsController>().getUnReadNotificationsCount();
    }
  }
}
