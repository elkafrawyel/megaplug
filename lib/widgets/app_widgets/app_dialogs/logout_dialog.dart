import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/constants.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:get/get.dart';

import '../app_text.dart';

void scaleAlertDialog({
  required BuildContext context,
  required String title,
  required String body,
  required String confirmText,
  required String cancelText,
  required VoidCallback onConfirmClick,
  bool barrierDismissible = false,
  int animationDuration = 400,
}) {
  if (!context.mounted) {
    return;
  }
  showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: title,
    pageBuilder: (ctx, a1, a2) => Container(),
    transitionDuration: Duration(milliseconds: animationDuration),
    transitionBuilder: (ctx, a1, a2, child) {
      var curve = Curves.easeInOut.transform(a1.value);
      return Transform.scale(
        scale: curve,
        child: GetPlatform.isIOS
            ? CupertinoTheme(
              data: CupertinoThemeData(
                brightness: StorageClient().isDarkMode()
                    ? Brightness.dark
                    : Brightness.light,
                scaffoldBackgroundColor: ctx.kBackgroundColor,
              ),
              child: CupertinoAlertDialog(
                title: AppText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                content: AppText(
                  text: body,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  maxLines: 5,
                ),
                actions: [
                  TextButton(
                    onPressed: onConfirmClick,
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ctx.kErrorColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        color: ctx.kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            )
            : AlertDialog(
                // insetPadding: EdgeInsets.zero,
                title: AppText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                content: AppText(
                  text: body,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  maxLines: 2,
                ),
                backgroundColor: ctx.kBackgroundColor,
                // contentPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRadius),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: onConfirmClick,
                    child: Text(
                      confirmText,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ctx.kErrorColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      cancelText,
                      style: TextStyle(
                        color: ctx.kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              ),
      );
    },
  );
}

showLogoutAlertDialog(
  BuildContext context,
  Function() onConfirmClick,
) {
  bool isAr = StorageClient().isAr();

  scaleAlertDialog(
    context: context,
    title: isAr ? 'تسجيل الخروج' : 'Logout',
    body: isAr
        ? 'هل انت متأكد من تسجيل الخروج ؟'
        : 'Are you sure you want to logout ?',
    confirmText: isAr ? 'تسجيل الخروج' : 'Logout',
    cancelText: isAr ? 'إلغاء' : 'Cancel',
    onConfirmClick: onConfirmClick,
  );
}

showDeleteAccountAlertDialog(
  BuildContext context,
  Function() onConfirmClick,
) {
  bool isAr = StorageClient().isAr();

  scaleAlertDialog(
    context: context,
    title: isAr ? 'حذف الحساب' : 'Delete Account',
    body: isAr
        ? 'هل انت متأكد من حذف حسابك ؟'
        : 'Are you sure you want to delete your account ?',
    confirmText: isAr ? 'حذف' : 'Delete',
    cancelText: isAr ? 'إلغاء' : 'Cancel',
    onConfirmClick: onConfirmClick,
  );
}
