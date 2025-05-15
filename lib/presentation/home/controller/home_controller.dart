import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/charge/charge_screen.dart';
import '../pages/profile/profile_screen.dart';
import '../pages/settings/settings_screen.dart';
import '../pages/stations/controller/stations_controller.dart';
import '../pages/stations/stations_screen.dart';
import '../pages/wallet/wallet_screen.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
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

  handleSelectedIndex(int index) {
    if (index > 0) {
      Get.find<StationsController>().showComingSoonDialog();
      return;
    }
    selectedIndex = index;
    update();
    pageController.jumpToPage(index);
  }
}
