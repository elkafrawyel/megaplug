import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/controller/home/home_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../widgets/app_widgets/app_bars/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color unSelectedColor = Color(0xff9DB2CE);
    final double chargeIconHeight = 80;
    return GetBuilder<HomeController>(
      builder: (homeController) {
        int selectedIndex = homeController.selectedIndex;
        return Scaffold(
          bottomNavigationBar: SafeArea(
            bottom: Platform.isIOS,
            child: Stack(
              clipBehavior: Clip.none,
              fit: StackFit.passthrough,
              children: [
                SvgPicture.asset(
                  Res.bottomNavBgIcon,
                  width: MediaQuery.sizeOf(context).width,
                  fit: BoxFit.fill,
                ),
                PositionedDirectional(
                  top: -chargeIconHeight / 2,
                  bottom: 0,
                  start: 0,
                  end: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 28.0,
                      vertical: 12.0,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //stations
                          GestureDetector(
                            onTap: () => homeController.handleSelectedIndex(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 0
                                      ? Res.homeIcon
                                      : Res.homeGrayIcon,
                                ),
                                5.ph,
                                AppText(
                                  text: 'stations'.tr,
                                  color: selectedIndex == 0
                                      ? context.kPrimaryColor
                                      : unSelectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          //wallet
                          GestureDetector(
                            onTap: () => homeController.handleSelectedIndex(1),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 1
                                      ? Res.walletIcon
                                      : Res.walletGrayIcon,
                                ),
                                5.ph,
                                AppText(
                                  text: 'wallet'.tr,
                                  color: selectedIndex == 1
                                      ? context.kPrimaryColor
                                      : unSelectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          //charge
                          GestureDetector(
                            onTap: () => homeController.handleSelectedIndex(2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 2
                                      ? Res.chargeOnIcon
                                      : Res.chargeOffIcon,
                                ),
                                5.ph,
                                AppText(
                                  text: 'charge'.tr,
                                  color: selectedIndex == 2
                                      ? context.kPrimaryColor
                                      : unSelectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),

                          //profile
                          GestureDetector(
                            onTap: () => homeController.handleSelectedIndex(3),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 3
                                      ? Res.profileIcon
                                      : Res.profileGrayIcon,
                                ),
                                5.ph,
                                AppText(
                                  text: 'profile'.tr,
                                  color: selectedIndex == 3
                                      ? context.kPrimaryColor
                                      : unSelectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ), //settings
                          GestureDetector(
                            onTap: () => homeController.handleSelectedIndex(4),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  selectedIndex == 4
                                      ? Res.settingsIcon
                                      : Res.settingsGrayIcon,
                                ),
                                5.ph,
                                AppText(
                                  text: 'settings'.tr,
                                  color: selectedIndex == 4
                                      ? context.kPrimaryColor
                                      : unSelectedColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: PageView.builder(
            controller: homeController.pageController,
            itemCount: homeController.pages.length,
            onPageChanged: (index) {
              homeController.handleSelectedIndex(index);
            },
            itemBuilder: (context, index) {
              return homeController.pages[index];
            },
          ),
        );
      },
    );
  }
}
