import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/presentation/home/pages/wallet/controller/wallet_controller.dart';

import '../../charging_session/charging_session_screen.dart';
import '../pages/charge/charge_screen.dart';
import '../pages/charge/controller/charge_controller.dart';
import '../pages/profile/profile_screen.dart';
import '../pages/settings/settings_screen.dart';
import '../pages/stations/controller/stations_controller.dart';
import '../pages/stations/stations_screen.dart';
import '../pages/wallet/wallet_screen.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  RxInt selectedIndex = 0.obs;
  List<Widget> pages = [];

  final PageController pageController = PageController();

  @override
  onInit() {
    super.onInit();
    pages = [
      StationsScreen(),
      WalletScreen(),
      ChargeScreen(),
      ProfileScreen(),
      SettingsScreen(),
    ];
  }

  handleSelectedIndex(int index) async {
    if (index != 0 && index != 1 && index != 2 && index != 3) {
      Get.find<StationsController>().showComingSoonDialog(Get.context!);
      return;
    }

    selectedIndex.value = index;
    pageController.jumpToPage(index);

    if (index == 1 && !WalletController.to.balanceResult.isStart()) {
      WalletController.to.refreshApi();
    }

    if (index == 2) {
      String? transactionId = ChargeController.to.getTransactionId();
      if (transactionId != null) {
        await Get.to(
          () => ChargingSessionScreen(
            transactionId: transactionId,
          ),
        );
        handleSelectedIndex(0);
      }
    }
  }
}
