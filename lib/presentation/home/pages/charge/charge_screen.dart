import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/charge/components/scanner_view.dart';

import '../../../../config/app_loader.dart';
import '../../../../config/res.dart';
import '../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../components/home_appbar.dart';
import 'components/charge_wallet_view.dart';
import 'components/swipe_to_charge_view.dart';

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0),
        child: ScannerView(
          key: scannerKey,
          onScanCompleted: (String qrValue) async {
            AppLoader.loading();
            await Future.delayed(Duration(seconds: 2));
            AppLoader.dismiss();
            //todo load station by id here
            if (context.mounted) {
              showAppModalBottomSheet(
                context: context,
                child: SwipeToChargeView(
                  barcodeValue: qrValue,
                ),
              ).then((_) async {
                scannerKey.currentState?.restartScanner();
              });
            }

            // if (context.mounted) {
            //   showAppModalBottomSheet(
            //     context: context,
            //     child: ChargeWalletView(),
            //   );
            // }
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

// body: Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   mainAxisAlignment: MainAxisAlignment.start,
//   children: [
//     80.ph,
//     SvgPicture.asset(
//       Res.chargePicIcon,
//       height: MediaQuery.sizeOf(context).width * 0.6,
//     ),
//     40.ph,
//     AppText(
//       text: 'ready_for_scan'.tr,
//       fontSize: 18,
//       fontWeight: FontWeight.bold,
//     ),
//     20.ph,
//     Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 38.0),
//       child: AppText(
//         text: 'charge_description'.tr,
//         maxLines: 3,
//         centerText: true,
//         color: context.kHintTextColor,
//         height: 2,
//       ),
//     ),
//     10.ph,
//     Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         AppText(text: 'have_any_trouble'.tr),
//         5.pw,
//         InkWell(
//           onTap: () {
//             Get.to(() => HowToChargeScreen());
//           },
//           child: AppText(
//             text: 'how_to_charge'.tr,
//             color: context.kPrimaryColor,
//           ),
//         ),
//       ],
//     ),
//     50.ph,
//     SizedBox(
//       width: MediaQuery.sizeOf(context).width * 0.8,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: context.kPrimaryColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onPressed: () {
//           ChargeController.to.setTransactionId('sadfasf');
//           Get.to(() => ChargingSessionScreen());
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(kButtonHeight),
//           child: AppText(
//             text: 'scan_qr_now'.tr,
//             color: context.kColorOnPrimary,
//           ),
//         ),
//       ),
//     ),
//     10.ph,
//     SizedBox(
//       width: MediaQuery.sizeOf(context).width * 0.8,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: context.kErrorColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         onPressed: () {
//           ChargeController.to.stopCharge();
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(kButtonHeight),
//           child: AppText(
//             text: 'Stop Charging'.tr,
//             color: context.kColorOnPrimary,
//           ),
//         ),
//       ),
//     )
//   ],
// ),
