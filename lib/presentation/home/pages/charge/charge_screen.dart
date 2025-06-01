import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/charge/components/scanner_view.dart';
import 'package:megaplug/presentation/home/pages/charge/controller/charge_controller.dart';

import '../../../../config/res.dart';
import '../../components/home_appbar.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<ScannerViewState> scannerKey = GlobalKey<ScannerViewState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: context.kBackgroundColor,
      extendBody: true,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charge'.tr,
      ),
      body: Obx(
        () {
          return ChargeController.to.isCharging.value
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  child: ScannerView(),
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
