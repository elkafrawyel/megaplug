import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:oktoast/oktoast.dart' as ok_toast;

abstract class InformationViewer {
  static showToast({
    required String msg,
    double fontSize = 16.0,
    required Color backgroundColor,
    Color? textColor,
  }) {
    ok_toast.showToast(
      msg,
      textPadding: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
      backgroundColor: backgroundColor,
      position: ok_toast.ToastPosition.bottom,
      textStyle: TextStyle(fontSize: fontSize, color: textColor),
    );
  }

  static showErrorToast({
    required String msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    showToast(
      msg: msg,
      backgroundColor: Colors.red,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static showSuccessToast({
    String? msg,
    double fontSize = 16.0,
    Color textColor = Colors.white,
  }) {
    if (msg == null) {
      return;
    }

    showToast(
      msg: msg,
      backgroundColor: Colors.green,
      textColor: textColor,
      fontSize: fontSize,
    );
  }

  static showSnackBar({
    required String msg,
    int duration = 5,
    Color? bgColor,
  }) {
    BuildContext? context = Get.context;

    if (context == null) {
      return;
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: bgColor ?? context.kPrimaryColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Text(
          msg,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          maxLines: 3,
        ),
        duration: Duration(seconds: duration),
        showCloseIcon: false,
        dismissDirection: DismissDirection.down,
        action: SnackBarAction(
          label: 'ok'.tr,
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
      snackBarAnimationStyle: AnimationStyle(
        curve: Curves.fastEaseInToSlowEaseOut,
        duration: Duration(milliseconds: 1000),
      ),
    );
  }
}
