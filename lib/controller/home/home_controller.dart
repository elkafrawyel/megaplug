import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/home/pages/charge/charge_screen.dart';
import '../../screens/home/pages/profile/profile_screen.dart';
import '../../screens/home/pages/settings/settings_screen.dart';
import '../../screens/home/pages/stations/stations_screen.dart';
import '../../screens/home/pages/wallet/wallet_screen.dart';

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
    selectedIndex = index;
    update();
    pageController.jumpToPage(index);
  }
}
