import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/language/en.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/charge/components/popups/charge_bottom_view.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../config/helpers/logging_helper.dart';
import '../../../../../widgets/app_dialog_view.dart';
import '../../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../controller/charge_controller.dart';
import 'overlay/scan_window_overlay.dart';

class ScannerView extends StatefulWidget {
  const ScannerView({super.key});

  @override
  State<ScannerView> createState() => ScannerViewState();
}

class ScannerViewState extends State<ScannerView> with WidgetsBindingObserver {
  MobileScannerController? cameraController;
  bool _isDialogShowing = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }


  @override
  Future<void> dispose() async {
    super.dispose();
    await cameraController?.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  bool _shouldHandleResume = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _shouldHandleResume) {
      _shouldHandleResume = false;
      bool enabled = await checkCameraPermission();
      if (enabled) {
        setState(() {});
      }
    }
  }

  Future<bool> checkCameraPermission() async {
    var status = await Permission.camera.status;

    AppLogger.logWithGetX(status.name);
    if (status.isGranted) {
      return true;
    } else if (status.isDenied) {
      status = await Permission.camera.request();
      return status.isGranted;
    } else if (status.isPermanentlyDenied) {
      Get.dialog(
        Align(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppDialogView(
              title: 'camera_permission'.tr,
              message: 'camera_permission_message'.tr,
              onActionClicked: () async {
                Get.back(closeOverlays: true);
                _shouldHandleResume = true;
                openAppSettings();
              },
              actionText: 'ok'.tr,
            ),
          ),
        ),
        barrierDismissible: false,
      );
      return false;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkCameraPermission(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == true) {
            return _scannerView();
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText(
                      text: 'camera_permission_message'.tr,
                      centerText: true,
                      maxLines: 3,
                    ),
                    20.ph,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _shouldHandleResume = true;
                        openAppSettings();
                      },
                      child: AppText(
                        text: 'enable_camera_permission'.tr,
                        color: context.kColorOnPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  Widget _scannerView() {
    late final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(
        const Offset(0, 0),
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      height: MediaQuery.sizeOf(context).width * 0.8,
    );

    cameraController ??= MobileScannerController();

    return MobileScanner(
      scanWindow: scanWindow,
      controller: cameraController,
      onDetect: (barcodeCapture) async {
        final barcode = barcodeCapture.barcodes.first;
        final String? code = barcode.rawValue;

        if (!_isDialogShowing && code != null) {
          _isDialogShowing = true;

          //so that the station loading start while the sheet opens
          ChargeController.to.scanQr(code);

          //todo load station by id here
          await showAppModalBottomSheet(
            context: context,
            child: ChargeBottomSheet(
              serial: code,
            ),
          );

          _isDialogShowing = false;
        }
      },
      onDetectError: (object, stack) => AppLogger.logWithGetX('Error while scanning: $object\n$stack'),
      placeholderBuilder: (context, view) => Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      overlayBuilder: (context, view) {
        return ScanWindowOverlay(
          scanWindow: scanWindow,
          controller: cameraController!,
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(kRadius),
        );
      },
    );
  }
}
