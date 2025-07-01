import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../config/res.dart';
import '../../../widgets/app_widgets/app_text.dart';

class ConnectorCard extends StatelessWidget {
  final dynamic connector;

  const ConnectorCard({
    super.key,
    required this.connector,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 34) / 2, // 2 per row with spacing
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xffF5F5F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: connector,
            fontWeight: FontWeight.w500,
          ),
          5.ph,
          AppText(
            text: '22 kW (EGP 0.05/kW)',
            color: context.kHintTextColor,
            fontSize: 11,
          ),
          5.ph,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: '2 Available',
                color: context.kPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              Image.asset(
                Res.logo,
                width: 40,
                height: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
