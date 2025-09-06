import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            Res.notificationsIcon,
          ),
          20.ph,
          AppText(
            text: 'No Notifications Yet',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          8.ph,
          AppText(
            text: "You're all caught up! We'll notify you here once there’s something new.",
            color: context.kHintTextColor,
          ),
        ],
      ),
    );
  }
}
