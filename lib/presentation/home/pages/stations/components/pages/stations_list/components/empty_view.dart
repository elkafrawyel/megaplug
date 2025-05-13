import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Res.emptyIcon,
            width: 150,
            height: 150,
          ),
          20.ph,
          AppText(
            text: 'no_result'.tr,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 38.0),
            child: AppText(
              text: 'empty_message'.tr,
              color: context.kHintTextColor,
              maxLines: 4,
              fontSize: 14,
              fontWeight: FontWeight.w300,
              centerText: true,
            ),
          ),
        ],
      ),
    );
  }
}
