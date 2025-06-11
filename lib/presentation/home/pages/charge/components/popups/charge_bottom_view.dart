import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/widgets/bottom_sheet_parent.dart';
import 'package:megaplug/presentation/home/pages/charge/components/popups/charge_wallet_view.dart';
import 'package:megaplug/presentation/home/pages/charge/components/popups/swipe_to_charge_view.dart';

import '../../../../../../config/clients/api/api_result.dart';
import '../../../../../../widgets/app_widgets/app_text.dart';
import '../../controller/charge_controller.dart';
import 'error_view.dart';

class ChargeBottomSheet extends StatelessWidget {
  final String serial;

  const ChargeBottomSheet({
    super.key,
    required this.serial,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChargeController>(
      builder: (chargeController) {
        ApiResult apiResult = chargeController.scanQrApiResult;

        return BottomSheetParent(
          child: switch (apiResult) {
            ApiStart() => SizedBox(),
            ApiLoading() => SizedBox(
                height: MediaQuery.sizeOf(context).height / 3,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ApiEmpty() => Padding(
                padding: const EdgeInsets.all(38.0),
                child: AppText(
                  text: 'There is no station with this result',
                ),
              ),
            ApiSuccess() => SwipeToChargeView(),
            ApiFailure() => apiResult.getError().contains('INSUFFICIENT_BALANCE')
                ? ChargeWalletView(
                    data: apiResult.getFailureData(),
                  )
                : ErrorView(
                    message: apiResult.getError(),
                  ),
          },
        );
      },
    );
  }
}
