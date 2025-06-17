import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/widgets/app_data_state/app_disconnect_view.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:megaplug/widgets/app_widgets/app_modal_bottom_sheet.dart';

class OfflineHandler {
  static bool _dialogOpened = false;

  static Future<bool> isConnected() async {
    List<ConnectivityResult> connectivityResult = (await Connectivity().checkConnectivity());
    if (connectivityResult.first == ConnectivityResult.mobile) {
      AppLogger.logWithGetX('Connected to Mobile Network');
      return true;
    } else if (connectivityResult.first == ConnectivityResult.wifi) {
      AppLogger.logWithGetX('Connected to WiFi');
      return true;
    } else {
      AppLogger.logWithGetX('No internet connection');
      return false;
    }
  }

  static handle() async {
    Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> connectivityResult) {
        if (connectivityResult.contains(ConnectivityResult.mobile)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
          _hideGetXDialog();
        } else if (connectivityResult.contains(ConnectivityResult.none)) {
          _showNoConnectionDialog();
        } else {
          _showNoConnectionDialog();
        }
      },
    );
  }

  static _hideGetXDialog() {
    if (_dialogOpened) {
      Get.back();
      _dialogOpened = false;
      AppLogger.log(
        'Your connection was established',
      );
    }
  }

  static _showNoConnectionDialog() {
    if (_dialogOpened) {
      return;
    }

    showAppModalBottomSheet(
      context: Get.context!,
      child: const AppDisconnectView(),
    );
    _dialogOpened = true;
    AppLogger.log(
      'Your connection was lost',
      level: Level.error,
    );
  }
}
