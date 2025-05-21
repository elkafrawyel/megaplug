import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../widgets/app_widgets/app_text.dart';

class MetricCardView extends StatelessWidget {
  final String title;
  final String subtitle;
  final String assetName;

  const MetricCardView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          SvgPicture.asset(assetName),
          SizedBox(height: 8),
          AppText(
            text: title,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          SizedBox(height: 4),
          AppText(
            text: subtitle,
            color: context.kHintTextColor,
            fontSize: 11,
            centerText: true,
          ),
        ],
      ),
    );
  }
}
