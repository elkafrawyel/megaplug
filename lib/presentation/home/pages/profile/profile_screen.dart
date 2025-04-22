import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/auth/login/login_screen.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_dialogs/logout_dialog.dart';
import 'package:megaplug/widgets/app_widgets/app_list_tile.dart';

import '../../../../widgets/app_widgets/app_text.dart';
import '../../../edit_profile/edit_profile_screen.dart';
import 'components/profile_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    double appbarHeight = 150;
    double imageHeight = 100;
    return Scaffold(
      appBar: ProfileAppbar(
        svgAssetPath: Res.homeAppBarBg,
        height: appbarHeight,
        title: 'profile'.tr,
        imageHeight: imageHeight,
        userImage:
            'https://images.healthshots.com/healthshots/en/uploads/2020/12/08182549/positive-person.jpg',
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
                  Get.to(() => EditProfileScreen());
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
              child: GetBuilder<ProfileController>(
                builder: (_) {
                  return AppListTile(
                    leading: SvgPicture.asset(
                      Res.logoutIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'logout'.tr,
                    onTap: () async {
                      showLogoutAlertDialog(
                        context,
                        () async {
                           profileController.logout();
                        },
                      );
                    },
                  );
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
