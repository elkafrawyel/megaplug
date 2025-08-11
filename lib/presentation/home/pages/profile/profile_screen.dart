import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/charge_history/charge_history_screen.dart';
import 'package:megaplug/presentation/home/controller/home_controller.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_dialogs/logout_dialog.dart';
import 'package:megaplug/widgets/app_widgets/app_list_tile.dart';

import '../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../../../widgets/app_widgets/app_text.dart';
import '../../../../widgets/logout_popup.dart';
import '../../../edit_profile/edit_profile_screen.dart';
import '../stations/controller/stations_controller.dart';
import 'components/profile_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with AutomaticKeepAliveClientMixin {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double appbarHeight = 150;
    double imageHeight = 100;
    return GetBuilder<ProfileController>(builder: (profileController) {
      return Scaffold(
        backgroundColor: context.kBackgroundColor,
        appBar: ProfileAppbar(
          svgAssetPath: Res.homeAppBarBg,
          height: appbarHeight,
          title: 'profile'.tr,
          imageHeight: imageHeight,
          userImage: profileController.userModel?.avatar ?? '',
        ),
        body: RefreshIndicator(
          onRefresh: profileController.refreshData,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (imageHeight / 1.5).ph,
                AppText(
                  text: profileController.userModel?.name ?? '',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                5.ph,
                AppText(
                  text: profileController.userModel?.email ?? '',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.kHintTextColor,
                ),
                20.ph,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.editProfileIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'edit_profile'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                       // Get.find<StationsController>().showComingSoonDialog(Get.context!);
                      Get.to(() => EditProfileScreen());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.myCarsIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'my_cars'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                      Get.find<StationsController>().showComingSoonDialog(Get.context!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.chargingHistoryIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'charging_history'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                      // Get.find<StationsController>().showComingSoonDialog(Get.context!);

                      Get.to(() => ChargeHistoryScreen());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.menuWalletIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'wallet'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                      HomeController.to.pageController.jumpToPage(1);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.paymentMethodsIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'payment_methods'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                      Get.find<StationsController>().showComingSoonDialog(Get.context!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
                  child: AppListTile(
                    leading: SvgPicture.asset(
                      Res.loyaltyPointsIcon,
                      width: 30,
                      height: 30,
                    ),
                    title: 'loyalty_points'.tr,
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                    onTap: () {
                      Get.find<StationsController>().showComingSoonDialog(Get.context!);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
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
                          showAppModalBottomSheet(
                            context: context,
                            child: LogoutPopup(),
                          );
                        },
                      );
                    },
                  ),
                ),
                150.ph,
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
