import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../../config/helpers/logging_helper.dart';
import 'scan_window_overlay.dart';

class ScannerView extends StatefulWidget {
  final Function(String qrValue) onScanCompleted;

  const ScannerView({
    super.key,
    required this.onScanCompleted,
  });

  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> with WidgetsBindingObserver {
  late MobileScannerController controller;
  String? qrCodeValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller = MobileScannerController();
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    await controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Attempt to resume camera when returning
      restartScanner();
    }
  }

  void restartScanner() {
    AppLogger.logWithGetX('Restarting scanner...');
    qrCodeValue = '';
    // controller.start();
    AppLogger.logWithGetX('Scanner restarted');
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
      controller: controller,
      onDetect: (barcodeCapture) {
        // there is a value and bottom sheet is opened
        if (qrCodeValue?.isEmpty ?? false) {
          AppLogger.logWithGetX('Scanner stopped, already scanned');
          return;
        }
        AppLogger.logWithGetX(
            '======>${barcodeCapture.barcodes.first.rawValue}');
        if (barcodeCapture.barcodes.first.rawValue != null) {
          String newQrCodeValue = barcodeCapture.barcodes.first.rawValue!;
          AppLogger.logWithGetX('Barcode value : : : : $newQrCodeValue');

          if (qrCodeValue == newQrCodeValue) {
            AppLogger.logWithGetX('QR code value is the same, ignoring scan');
            return;
          }
          qrCodeValue = newQrCodeValue;
          widget.onScanCompleted(qrCodeValue!);
          AppLogger.logWithGetX('Scanner stopped after scanning');
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
          controller: controller,
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(kRadius),
        );
      },
    );
  }
}
