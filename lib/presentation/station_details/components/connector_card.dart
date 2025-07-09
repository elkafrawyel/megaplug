import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../config/res.dart';
import '../../../data/api_responses/station_details_response.dart';
import '../../../widgets/app_widgets/app_text.dart';

class ConnectorCard extends StatelessWidget {
  final ApiConnectorModel connector;

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
            text: connector.typeName ?? '',
            fontWeight: FontWeight.w500,
          ),
          5.ph,
          AppText(
            text: '${connector.powerDisplay ?? '0'} ${'kw'.tr} (${'egp'.tr} ${connector.pricePerKw ?? '0'}/${'kw'.tr})',
            color: context.kHintTextColor,
            fontSize: 11,
          ),
          5.ph,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(
                text: '${connector.count ?? '0'} ${connector.status ?? ''}',
                color: connector.status == 'Available' ? context.kPrimaryColor : context.kErrorColor,
                fontWeight: FontWeight.w500,
              ),
              Spacer(),
              AppNetworkImage(
                imageUrl: connector.typeImage ?? '',
                width: 50,
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
