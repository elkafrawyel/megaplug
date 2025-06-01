import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/wallet/components/wallet_view.dart';
import 'package:megaplug/presentation/home/pages/wallet/controller/wallet_controller.dart';

import '../../../../config/constants.dart';
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
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'wallet'.tr,
      ),
      body: RefreshIndicator(
        backgroundColor: context.kPrimaryColor,
        color: context.kColorOnPrimary,
        onRefresh: WalletController.to.refreshApi,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.ph,
            WalletView(),
            // Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: PointsView(
            //     points: 320,
            //   ),
            // ),
            Center(
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.kSecondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kRadius),
                    ),
                    padding: EdgeInsets.symmetric(vertical: kButtonHeight),
                  ),
                  onPressed: () {
                    WalletController.to.addBalance();
                  },
                  icon: Icon(
                    Icons.add,
                    color: context.kColorOnPrimary,
                  ),
                  label: AppText(
                    text: 'add_credit'.tr,
                    color: context.kColorOnPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              child: AppText(
                text: 'transactions_history'.tr,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(child: TransactionsHistoryList()),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
