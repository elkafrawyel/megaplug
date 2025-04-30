import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../../config/res.dart';
import '../../../../widgets/app_transformtion_view.dart';
import '../../../../widgets/app_widgets/app_text.dart';

class RegisterAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String svgAssetPath;
  final double height;
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final Color? backgroundColor;
  final double svgOpacity;

  const RegisterAppbar({
    super.key,
    required this.svgAssetPath,
    required this.title,
    this.height = 100,
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
      surfaceTintColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
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
                padding: const EdgeInsets.all(12.0),
                child: AppTransformationView(
                  child: SvgPicture.asset(
                    Res.backIcon,
                  ),
                ),
              ),
            )
          : SizedBox(),
      flexibleSpace: Stack(
        children: [
          // SVG Background
          Positioned.fill(
            child: AppTransformationView(
              child: Opacity(
                opacity: svgOpacity,
                child: SvgPicture.asset(
                  svgAssetPath,
                  fit: BoxFit.fill,
                ),
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
