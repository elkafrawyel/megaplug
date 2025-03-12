import 'package:flutter/material.dart';

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
    return Center(
      child: AppText(text: 'wallet'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
