import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/date_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../widgets/app_widgets/app_text.dart';

class ChargeHistoryCard extends StatelessWidget {
  const ChargeHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    bool isCarCharging = true; // This should be replaced with actual logic to determine if the car is charging
    return Stack(
      children: [
        Card(
          elevation: 0.0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    AppNetworkImage(
                      imageUrl: '',
                      width: 90,
                      height: 90,
                      radius: 8,
                    ),
                    10.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: AppText(
                                  text: 'Chilout Madinaty',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              AppText(
                                text: ' #43567',
                                fontSize: 12,
                                color: context.kHintTextColor,
                              ),
                            ],
                          ),
                          5.ph,
                          AppText(
                            text: 'Location: City, Country',
                            fontSize: 12,
                          ),
                          5.ph,
                          isCarCharging
                              ? AppText(
                                  text: 'charging_now'.tr,
                                  color: context.kPrimaryColor,
                                  fontWeight: FontWeight.w700,
                                )
                              : AppText(
                                  text: DateHelper().formatDateTime(DateTime.now().toIso8601String()),
                                  fontSize: 12,
                                  color: context.kHintTextColor,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                Wrap(
                  spacing: 10,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.network(
                          '',
                        ),
                        AppText(
                          text: 'ABB Terra 53 CJG Type 1',
                          color: Color(0xff6C7E8E),
                          fontSize: 13,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          Res.lightningIcon,
                          colorFilter: ColorFilter.mode(
                            context.kPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                        AppText(
                          text: '${'charging'.tr} 60% - 2500 KW',
                          fontSize: 12,
                          color: Color(0xff6C7E8E),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        PositionedDirectional(
          end: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: context.kPrimaryColor,
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(12),
                bottomStart: Radius.circular(12),
              ),
            ),
            child: AppText(
              text: '10.23 ${'egp'.tr}',
              color: context.kColorOnPrimary,
              fontSize: 12,
            ),
          ),
        )
      ],
    );
  }
}
