import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../../widgets/app_widgets/app_text.dart';

class PointsView extends StatelessWidget {
  final double points;

  const PointsView({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(4),
      padding: EdgeInsets.all(6),
      strokeCap: StrokeCap.square,
      color: Color(0xffE8E8E8),
      dashPattern: [12, 8],
      strokeWidth: 1.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            AppText(
              text: 'points'.tr,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            Spacer(),
            AppText(
              text: '$points ${'points'.tr}',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.kPrimaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
