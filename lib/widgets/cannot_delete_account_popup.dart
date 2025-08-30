import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';
import 'package:megaplug/widgets/bottom_sheet_parent.dart';

import '../presentation/charging_session/charging_session_screen.dart';
import '../presentation/home/controller/home_controller.dart';
import '../presentation/home/pages/charge/controller/charge_controller.dart';

class CannotDeleteAccountPopup extends StatelessWidget {
  const CannotDeleteAccountPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetParent(
      child: Column(
        children: [
          Center(
            child: SvgPicture.asset(
              Res.warningIcon,
            ),
          ),
          20.ph,
          AppText(
            text: 'Cannot Delete Account',
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          10.ph,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: AppText(
              text: "As you have active charging process, you can't delete your account.",
              fontWeight: FontWeight.w500,
              maxLines: 3,
              color: Color(0xff6D7698),
              centerText: true,
            ),
          ),
          20.ph,
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: AppButton(
              text: 'View Session',
              onPressed: () async {
                String? transactionId = ChargeController.to.getTransactionId();
                if (transactionId != null) {
                  // Close the bottom sheet
                  Get.back();

                  Get.to(
                    () => ChargingSessionScreen(
                      transactionId: transactionId,
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
