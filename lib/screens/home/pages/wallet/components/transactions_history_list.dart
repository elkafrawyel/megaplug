import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../../config/res.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class TransactionsHistoryList extends StatelessWidget {
  const TransactionsHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 0,
            color: Colors.white,
            child: Row(
              children: [
                SvgPicture.asset(
                  index % 2 == 0 ? Res.plusIcon : Res.chargedIcon,
                ),
                20.pw,
                Column(
                  children: [
                    AppText(
                      text: 'Loyalty Points',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    5.ph,
                    AppText(
                      text: 'Today • 4:32 pm',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    AppText(
                      text: '+ 32.00 EGP',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    5.ph,
                    Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Color.fromRGBO(
                                74,
                                222,
                                128,
                                0.2,
                              )
                            : Color.fromRGBO(255, 113, 113, 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4.0,
                        ),
                        child: AppText(
                          text: 'Loyalty Points ',
                          color: index % 2 == 0
                              ? context.kPrimaryColor
                              : Color(0xffF41F52),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => 10.ph,
        itemCount: 20,
      ),
    );
  }
}
