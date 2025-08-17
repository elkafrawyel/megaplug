import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/date_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/charging_history_model.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';

import '../../../widgets/app_widgets/app_text.dart';

class ChargeHistoryCard extends StatelessWidget {
  final ChargingHistoryModel chargingHistoryModel;

  const ChargeHistoryCard({
    super.key,
    required this.chargingHistoryModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin: EdgeInsets.symmetric(vertical: 8),
          elevation: 0.0,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    AppNetworkImage(
                      imageUrl: chargingHistoryModel.chargingPoint?.station?.image ?? '',
                      width: 90,
                      height: 90,
                      radius: 8,
                    ),
                    10.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: chargingHistoryModel.chargingPoint?.station?.nameEn ?? '',
                            fontWeight: FontWeight.w500,
                          ),
                          5.ph,
                          AppText(
                            text: ' #${chargingHistoryModel.transactionId}',
                            fontSize: 12,
                            color: context.kHintTextColor,
                          ),
                          5.ph,
                          AppText(
                            text: chargingHistoryModel.chargingPoint?.station?.addressEn ?? '',
                            fontSize: 12,
                          ),
                          5.ph,
                          !(chargingHistoryModel.isFinished ?? false)
                              ? AppText(
                                  text: 'charging_now'.tr,
                                  color: context.kPrimaryColor,
                                  fontWeight: FontWeight.w400,
                                )
                              : AppText(
                                  text: DateHelper().formatDateTime(chargingHistoryModel.startedAt),
                                  fontSize: 12,
                                  color: context.kHintTextColor,
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
                10.ph,
                Row(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.network(
                          chargingHistoryModel.connector?.connectorType?.symbol ?? '',
                          width: 20,
                          height: 20,
                        ),
                        5.pw,
                        AppText(
                          text:
                              '${chargingHistoryModel.connector?.connectorType?.toString() ?? ''} , ${chargingHistoryModel.connector?.chargePower?.nameEn} , ${(chargingHistoryModel.connector?.connectorType?.isDc ?? false) ? 'DC' : 'AC'}',
                          color: Color(0xff6C7E8E),
                          fontSize: 13,
                        ),
                      ],
                    ),
                    10.pw,
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Res.lightningIcon,
                            colorFilter: ColorFilter.mode(
                              (chargingHistoryModel.isFinished ?? false) ? context.kPrimaryColor : Color(0xffFFA800),
                              BlendMode.srcIn,
                            ),
                          ),
                          Expanded(
                            child: AppText(
                              text: !(chargingHistoryModel.isFinished ?? false)
                                  ? 'charging_now'.tr
                                  : '${chargingHistoryModel.soc == null ? '' : '${'charging'.tr} ' '${chargingHistoryModel.soc}% -'} ${chargingHistoryModel.energyConsumed} ${'kw'.tr}',
                              maxLines: 2,
                              fontSize: 12,
                              color: Color(0xff6C7E8E),
                            ),
                          ),
                        ],
                      ),
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
          child: !(chargingHistoryModel.isFinished ?? false)
              ? Image.asset(
                  Res.chargingImage,
                  width: 70,
                  height: 70,
                )
              : Container(
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
                    text: '${chargingHistoryModel.overallCost} ${'egp'.tr}',
                    color: context.kColorOnPrimary,
                    fontSize: 12,
                  ),
                ),
        )
      ],
    );
  }
}
