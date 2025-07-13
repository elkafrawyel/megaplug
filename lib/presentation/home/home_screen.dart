import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/offline_mixin.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/charge/components/popups/error_view.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../widgets/app_data_state/app_disconnect_view.dart';
import '../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../widgets/bottom_sheet_parent.dart';
import 'controller/home_controller.dart';
import 'pages/charge/controller/charge_controller.dart';
import 'pages/stations/controller/stations_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with OfflineMixin {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final Color unSelectedColor = Color(0xff9DB2CE);
    final double bottomNavHeight = 90;

    return Obx(() {
      int selectedIndex = homeController.selectedIndex.value;
      return Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(
                  MediaQuery.of(context).size.width,
                  bottomNavHeight,
                ),
                painter: BottomNavBarPainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 24,
                horizontal: 12.0,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //stations
                  Expanded(
                    child: GestureDetector(
                      onTap: () => HomeController.to.pageController.jumpToPage(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            selectedIndex == 0 ? Res.homeIcon : Res.homeGrayIcon,
                          ),
                          5.ph,
                          AppText(
                            text: 'stations'.tr,
                            color: selectedIndex == 0 ? context.kPrimaryColor : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 0 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //wallet
                  Expanded(
                    child: GestureDetector(
                      onTap: () => HomeController.to.pageController.jumpToPage(1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            selectedIndex == 1 ? Res.walletIcon : Res.walletGrayIcon,
                          ),
                          5.ph,
                          AppText(
                            text: 'wallet'.tr,
                            color: selectedIndex == 1 ? context.kPrimaryColor : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 1 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //charge
                  Expanded(
                    child: GestureDetector(
                      onTap: () => HomeController.to.pageController.jumpToPage(2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ChargeController.to.isCharging.value
                              ? SvgPicture.asset(
                                  key: ValueKey(selectedIndex),
                                  Res.chargeOnIcon,
                                )
                                  .animate(onPlay: (controller) => controller.repeat()) // loop
                                  .rotate(
                                    duration: Duration(seconds: 2),
                                  ) // 2-second full rotation
                              : SvgPicture.asset(
                                  Res.chargeOffIcon,
                                ),
                          5.ph,
                          AppText(
                            text: 'charge'.tr,
                            color: selectedIndex == 2 ? context.kPrimaryColor : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 2 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //profile
                  Expanded(
                    child: GestureDetector(
                      // onTap: () => Get.find<StationsController>().showComingSoonDialog(Get.context!),
                      onTap: () => HomeController.to.pageController.jumpToPage(3),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            selectedIndex == 3 ? Res.profileIcon : Res.profileGrayIcon,
                          ),
                          5.ph,
                          AppText(
                            text: 'profile'.tr,
                            color: selectedIndex == 3 ? context.kPrimaryColor : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 3 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //settings
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Get.find<StationsController>().showComingSoonDialog(Get.context!),

                      // onTap: () => HomeController.to.pageController.jumpToPage(4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            selectedIndex == 4 ? Res.settingsIcon : Res.settingsGrayIcon,
                          ),
                          5.ph,
                          AppText(
                            text: 'settings'.tr,
                            color: selectedIndex == 4 ? context.kPrimaryColor : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 4 ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
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
    });
  }

  bool isDisconnectedViewOpened = false;

  @override
  void onNotify({bool? isConnected}) {
    if (isConnected == false) {
      showAppModalBottomSheet(
        context: context,
        child: BottomSheetParent(
          hideBack: true,
          child: const ErrorView(
            message: 'Check your internet connection and try again.',
          ),
        ),
      );
      isDisconnectedViewOpened = true;
    } else {
      if (isDisconnectedViewOpened) {
        Get.back();
        isDisconnectedViewOpened = false;
      }
    }
  }
}

class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0.637848);
    path.cubicTo(0, 0.637848, size.width * 0.304, 18.5417, size.width * 0.5, 18.5417);
    path.cubicTo(size.width * 0.696, 18.5417, size.width, 0.637848, size.width, 0.637848);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
