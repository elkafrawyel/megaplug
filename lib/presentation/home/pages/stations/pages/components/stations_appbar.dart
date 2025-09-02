import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:megaplug/presentation/notifications/notifications_screen.dart';
import '../../../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../../widgets/app_widgets/app_network_image.dart';
import '../../controller/stations_controller.dart';
import 'search_view.dart';

class StationsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final List<Widget>? actions;
  final double svgOpacity;
  final Color? backgroundColor;

  const StationsAppbar({
    super.key,
    required this.height,
    this.backgroundColor,
    this.actions,
    this.svgOpacity = 1,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      title: GetBuilder<ProfileController>(
        builder: (profileController) {
          return GetBuilder<StationsController>(
              id: StationsController.stationsControllerId,
              builder: (stationsController) {
                return AppText(
                  text: '${'hi'.tr} ${profileController.userModel?.name ?? ''}',
                  color: stationsController.mapView ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w400,
                );
              });
        },
      ),
      leading: GetBuilder<ProfileController>(
        builder: (profileController) {
          if (profileController.userModel?.avatar == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 18.0),
            child: AppNetworkImage(
              isCircular: true,
              fit: BoxFit.cover,
              imageUrl: profileController.userModel?.avatar ?? '',
            ),
          );
        },
      ),
      centerTitle: false,
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => NotificationsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: GetBuilder<StationsController>(
                  id: StationsController.notificationsCountViewControllerId,
                  builder: (stationsController) {
                    return badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: context.kSecondaryColor,
                      ),
                      showBadge: stationsController.unReadNotificationsCount > 0,
                      position: badges.BadgePosition.topStart(top: -10, start: -7),
                      badgeContent: AppText(
                        text: stationsController.unReadNotificationsCount.toString(),
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      child: SvgPicture.asset(
                        Res.notificationsIcon,
                        width: 20,
                        height: 20,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        )
      ],
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          // SVG Background
          GetBuilder<StationsController>(
              id: StationsController.stationsControllerId,
              builder: (stationsController) {
                return Positioned.fill(
                  child: Opacity(
                    opacity: stationsController.mapView ? 0 : 1,
                    child: SvgPicture.asset(
                      Res.homeAppBarBg,
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        stationsController.mapView ? Colors.transparent : context.kPrimaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }),
          PositionedDirectional(
            bottom: -15,
            start: 0,
            end: 0,
            child: SearchView(),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
