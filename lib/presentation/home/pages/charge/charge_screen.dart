import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/charge/components/scanner_view.dart';
import 'package:megaplug/presentation/home/pages/charge/controller/charge_controller.dart';

import '../../../../config/res.dart';
import '../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../components/home_appbar.dart';
import 'components/popups/charge_bottom_view.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> with AutomaticKeepAliveClientMixin {
  GlobalKey<ScannerViewState> scannerKey = GlobalKey<ScannerViewState>();

  manualScan(String code) async {
    ChargeController.to.scanQr(code);
    showAppModalBottomSheet(
      context: context,
      child: ChargeBottomSheet(
        serial: code,
      ),
    );
  }

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
              : InkWell(
                  onTap: () {
                    manualScan('5403000060');
                  },
                  child: ScannerView(),
                );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
