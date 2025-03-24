import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/home_appbar.dart';

import '../../../../widgets/app_widgets/app_text.dart';

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
      body: Column(
        children: [
          HomeAppbar(
            title: 'wallet'.tr,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
