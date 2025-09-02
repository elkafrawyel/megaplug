import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/presentation/notifications/components/empty_view.dart';
import 'package:megaplug/presentation/notifications/components/notification_cardView.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/app_paginated_listview.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';

import '../../domain/entities/api/notification_model.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 38.0,horizontal: 8.0),
        child: AppPaginatedListview<NotificationModel>(
          child: (notificationModel) => NotificationCardView(notificationModel: notificationModel),
          emptyView: EmptyView(),
          configData: ConfigData(
            apiEndPoint: Res.apiNotifications,
            fromJson: NotificationModel.fromJson,
          ),
        ),
      ),
    );
  }
}
