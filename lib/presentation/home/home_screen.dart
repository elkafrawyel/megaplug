import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import 'controller/home_controller.dart';

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

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final Color unSelectedColor = Color(0xff9DB2CE);
    final double bottomNavHeight = 90;

    return Obx(() {
      int selectedIndex = homeController.selectedIndex.value;
      return Scaffold(
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
                            fontWeight: selectedIndex == 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //wallet
                  Expanded(
                    child: GestureDetector(
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
                            fontWeight: selectedIndex == 1
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //charge
                  Expanded(
                    child: GestureDetector(
                      onTap: () => homeController.handleSelectedIndex(2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Animate(
                            key: ValueKey(selectedIndex),
                            // forces animation restart
                            child: SvgPicture.asset(
                              key: ValueKey(selectedIndex),
                              selectedIndex == 2
                                  ? Res.chargeOnIcon
                                  : Res.chargeOffIcon,
                            ),
                          ).rotate(
                            begin: 0,
                            end: 1, // full turn (360 degrees)
                            duration: 1000.ms,
                            curve: Curves.linear,
                          ),
                          // (selectedIndex == 2
                          //         ? SvgPicture.asset(
                          //             key: ValueKey(1),
                          //             Res.chargeOnIcon,
                          //           )
                          //         : SvgPicture.asset(
                          //             key: ValueKey(1),
                          //             Res.chargeOffIcon,
                          //           ))
                          //     .animate(
                          //       key: ValueKey(
                          //           homeController.selectedIndex.value),
                          //       onPlay: (c) => c.repeat(min: 1, max: 1),
                          //     )
                          //     .rotate(
                          //       begin: 0,
                          //       end: 0.5,
                          //       duration: 700.ms,
                          //       curve: Curves.easeInOut,
                          //     ),
                          5.ph,
                          AppText(
                            text: 'charge'.tr,
                            color: selectedIndex == 2
                                ? context.kPrimaryColor
                                : unSelectedColor,
                            fontSize: 12,
                            fontWeight: selectedIndex == 2
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //profile
                  Expanded(
                    child: GestureDetector(
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
                            fontWeight: selectedIndex == 3
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ), //settings
                  Expanded(
                    child: GestureDetector(
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
                            fontWeight: selectedIndex == 4
                                ? FontWeight.w600
                                : FontWeight.w400,
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
}

class BottomNavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0.637848);
    path.cubicTo(
        0, 0.637848, size.width * 0.304, 18.5417, size.width * 0.5, 18.5417);
    path.cubicTo(size.width * 0.696, 18.5417, size.width, 0.637848, size.width,
        0.637848);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
