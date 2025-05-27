import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/date_helper.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/domain/entities/api/transaction_model.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/app_paginated_listview.dart';
import 'package:megaplug/widgets/app_widgets/paginated_views/paginated_controller/data/config_data.dart';

import '../../../../../config/res.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class TransactionsHistoryList extends StatelessWidget {
  const TransactionsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPaginatedListview<TransactionModel>(
      configData: ConfigData(
        apiEndPoint: Res.apiTransactions,
        fromJson: TransactionModel.fromJson,
      ),
      emptyView: Center(
        child: AppText(text: 'no_transactions_history'.tr),
      ),
      child: (TransactionModel model) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 4.0),
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    model.typeValue == 2 || model.typeValue == 3
                        ? Res.plusIcon
                        : Res.chargedIcon,

                  ),
                  10.pw,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: model.description ?? '',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      5.ph,
                      AppText(
                        text: DateHelper().formatDateTime(model.createdAt!),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xffA3A3A3),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppText(
                        text:
                            '${model.typeValue == 2 || model.typeValue == 3 ? '+' : '-'} ${model.amount ?? '0.0'} ${'egp'.tr}',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                      5.ph,
                      Container(
                        decoration: BoxDecoration(
                          color: model.typeValue == 2 || model.typeValue == 3
                              ? Color.fromRGBO(
                                  74,
                                  222,
                                  128,
                                  0.2,
                                )
                              : Color.fromRGBO(255, 113, 113, 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4.0,
                          ),
                          child: AppText(
                            text: model.type ?? '',
                            color: model.typeValue == 2 || model.typeValue == 3
                                ? context.kPrimaryColor
                                : Color(0xffF41F52),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
