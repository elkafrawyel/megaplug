import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../widgets/app_widgets/app_text.dart';
import '../../components/home_appbar.dart';
import 'components/transactions_history_list.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox();

    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'wallet'.tr,
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: DottedBorder(
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        Spacer(),
                        AppText(
                          text: '320 ${'points'.tr}',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: context.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: context.kSecondaryColor),
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: context.kColorOnPrimary,
                    ),
                    label: AppText(
                      text: 'add_credit'.tr,
                      color: context.kColorOnPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              10.ph,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: AppText(
                  text: 'transactions_history'.tr,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TransactionsHistoryList(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
