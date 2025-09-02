import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/date_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/notification_model.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class NotificationCardView extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCardView({super.key, required this.notificationModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SvgPicture.asset(Res.settingsIcon),
            ),
            8.pw,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: DateHelper().formatDateTime(DateTime.now().toIso8601String()),
                          fontSize: 12,
                          color: Color(0xff191919),
                        ),
                      ),
                      if (notificationModel.readAt == null)
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: context.kSecondaryColor),
                        ),
                    ],
                  ),
                  5.ph,
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 18.0),
                    child: AppText(
                      text: 'Payment Has Been Processed Successfully',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  5.ph,
                  AppText(
                    text: 'The charging station GreenFlow is 3 km away from your location.!',
                    fontWeight: FontWeight.w400,
                    maxLines: 4,
                    color: context.kHintTextColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
