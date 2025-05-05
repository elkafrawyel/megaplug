import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_network_image.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../../../../widgets/app_widgets/app_text.dart';
import '../../../controller/stations_controller.dart';
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
    return GetBuilder<StationsController>(
      builder: (stationsController) => AppBar(
        toolbarHeight: kToolbarHeight,
        backgroundColor: backgroundColor ?? Colors.transparent,
        elevation: 0,
        title: GetBuilder<ProfileController>(
          builder: (profileController) {
            return AppText(
              text: '${'hi'.tr} ${profileController.userModel?.name ?? ''}',
              color: stationsController.mapView ? Colors.black : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            );
          },
        ),
        leading: GetBuilder<ProfileController>(
          builder: (profileController) {
            // if (profileController.userModel?.image == null) {
            //   return const SizedBox();
            // }
            return Padding(
              padding: const EdgeInsetsDirectional.only(start: 18.0),
              child: AppNetworkImage(
                isCircular: true,
                fit: BoxFit.cover,
                imageUrl: profileController.userModel?.image ??
                    'https://images.healthshots.com/healthshots/en/uploads/2020/12/08182549/positive-person.jpg',
              ),
            );
          },
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: context.kSecondaryColor,
                  ),
                  position: badges.BadgePosition.topStart(top: -10, start: -7),
                  badgeContent: AppText(
                    text: '3',
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  child: Icon(
                    Icons.notifications_none,
                    color: Colors.black,
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
            Positioned.fill(
              child: Opacity(
                opacity: stationsController.mapView ? 0 : 1,
                child: SvgPicture.asset(
                  Res.homeAppBarBg,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            PositionedDirectional(
              bottom: -15,
              start: 0,
              end: 0,
              child: SearchView(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
