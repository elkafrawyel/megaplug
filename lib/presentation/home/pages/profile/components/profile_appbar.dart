import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../../config/res.dart';
import '../../../../../widgets/app_widgets/app_network_image.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class ProfileAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String svgAssetPath;
  final String userImage;
  final double height;
  final double imageHeight;
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final double svgOpacity;

  const ProfileAppbar({
    super.key,
    required this.svgAssetPath,
    required this.userImage,
    this.height = kToolbarHeight,
    this.imageHeight = 100,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.backgroundColor,
    this.svgOpacity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      title: AppText(
        text: title,
        color: context.kColorOnPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      actions: actions,
      leadingWidth: 50,
      leading: showBackButton
          ? GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Res.backIcon,
                ),
              ),
            )
          : SizedBox(),
      flexibleSpace: Stack(
        clipBehavior: Clip.none,
        children: [
          // SVG Background
          Positioned.fill(
            child: Opacity(
              opacity: svgOpacity,
              child: SvgPicture.asset(
                svgAssetPath,
                fit: BoxFit.fill,
              ),
            ),
          ),
          PositionedDirectional(
            bottom: -imageHeight / 2,
            start: 0,
            end: 0,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff9DB2CE),
                  width: 4,
                ),
                shape: BoxShape.circle,
              ),
              child: AppNetworkImage(
                imageUrl: userImage,
                isCircular: true,
                height: imageHeight,
                width: imageHeight,
                fit: BoxFit.fitHeight,
                borderColor: Color(0xff9DB2CE),
                borderWidth: 2,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
