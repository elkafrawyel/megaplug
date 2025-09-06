import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/bottom_sheet_parent.dart';

class LogoutPopup extends StatelessWidget {
  const LogoutPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetParent(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Res.logoutPopupIcon,
              ),
              10.ph,
              AppText(
                text: 'logout_title'.tr,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              5.ph,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppText(
                  text: 'logout_body'.tr,
                  color: context.kHintTextColor,
                  maxLines: 3,
                  centerText: true,
                ),
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'cancel'.tr,
                        onPressed: () {
                          Get.back();
                        },
                        backgroundColor: context.kErrorColor,
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: AppButton(
                        text: 'logout'.tr,
                        onPressed: () {
                          ProfileController.to.logout();
                        },
                        backgroundColor: context.kPrimaryColor,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
