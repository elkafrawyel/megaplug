import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/pages/profile/controller/profile_controller.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/app_widgets/app_text_field/app_text_field.dart';
import 'package:megaplug/widgets/bottom_sheet_parent.dart';

class DeleteAccountPopup extends StatelessWidget {
  DeleteAccountPopup({super.key});

  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BottomSheetParent(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Delete account',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  text:
                      "We're sorry to hear that you want to delete your account. If there's anything we can do to improve your experience, please let us know. We appreciate your time with us!",
                  color: context.kHintTextColor,
                  maxLines: 3,
                  fontSize: 13,
                ),
              ),
              AppTextFormField(
                controller: reasonController,
                hintText: 'Please provide a reason for deleting your account',
                maxLines: 3,
              ),
              20.ph,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        text: 'Change My Mind',
                        fontSize: 14,
                        onPressed: () {
                          Get.back();
                        },
                        backgroundColor: context.kPrimaryColor,
                      ),
                    ),
                    10.pw,
                    Expanded(
                      child: AppButton(
                        text: 'Delete',
                        fontSize: 14,
                        backgroundColor: context.kErrorColor,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          ProfileController.to.deleteAccount(reason: reasonController.text.isEmpty? null : reasonController.text);
                        },
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
