import 'dart:async';

import 'package:flutter/material.dart';
import 'package:megaplug/config/constants.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../config/helpers/logging_helper.dart';
import '../../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../controller/charge_controller.dart';
import 'scan_window_overlay.dart';
import 'swipe_to_charge_view.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> {
  late MobileScannerController cameraController;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(
        const Offset(0, -100),
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).width * 0.8,
    );

    return MobileScanner(
      scanWindow: scanWindow,
      controller: cameraController,
      onDetect: (barcodeCapture) async {
        final barcode = barcodeCapture.barcodes.first;
        final String? code = barcode.rawValue;

        if (!_isDialogShowing && code != null) {
          _isDialogShowing = true;

          //so that the station loading start while the sheet opens
          ChargeController.to.setTransactionId(code);

          //todo load station by id here
          await showAppModalBottomSheet(
            context: context,
            child: SwipeToChargeView(),
          );

          _isDialogShowing = false;
        }
      },
      onDetectError: (object, stack) =>
          AppLogger.logWithGetX('Error while scanning: $object\n$stack'),
      placeholderBuilder: (context, view) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      overlayBuilder: (context, view) {
        return ScanWindowOverlay(
          scanWindow: scanWindow,
          controller: cameraController,
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(kRadius),
        );
      },
    );
  }
}
