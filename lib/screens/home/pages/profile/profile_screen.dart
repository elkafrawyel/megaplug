import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/home/pages/profile/components/header_view.dart';
import 'package:megaplug/widgets/app_widgets/app_list_tile.dart';

import '../../../../widgets/app_widgets/app_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    double headerBgHeight = MediaQuery.sizeOf(context).height * 0.20;
    double imageHeight = 120;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeaderView(
              height: headerBgHeight,
              imageHeight: imageHeight,
            ),
            (imageHeight / 1.5).ph,
            AppText(
              text: 'Ahmed Bakry',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            5.ph,
            AppText(
              text: 'Megaplug@gmail.com',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: context.kHintTextColor,
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.editProfileIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'edit_profile'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('edit_profile');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.myCarsIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'my_cars'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('my_cars');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.chargingHistoryIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'charging_history'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('charging_history');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.menuWalletIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'wallet'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('wallet');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.paymentMethodsIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'payment_methods'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('payment_methods');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.loyaltyPointsIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'loyalty_points'.tr,
                trailing: Icon(
                  Icons.keyboard_arrow_right,
                ),
                onTap: () {
                  AppLogger.getxLog('loyalty_points');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
              child: AppListTile(
                leading: SvgPicture.asset(
                  Res.logoutIcon,
                  width: 30,
                  height: 30,
                ),
                title: 'logout'.tr,
                onTap: () {
                  AppLogger.getxLog('logout');
                },
              ),
            ),
            100.ph,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
