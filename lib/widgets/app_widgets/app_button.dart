import 'package:flutter/material.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import 'app_text.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsDirectional? padding;
  final double? elevation;
  final double? radius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.elevation,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: elevation ?? 0.0,
        disabledBackgroundColor: context.kHintTextColor,
        backgroundColor: backgroundColor ?? context.kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        padding: padding,
      ),
      onPressed: onPressed,
      child: AppText(
        text: text,
        color: textColor ?? context.kColorOnPrimary,
      ),
    );
  }
}
