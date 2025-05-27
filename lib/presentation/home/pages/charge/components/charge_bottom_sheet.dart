import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/presentation/home/pages/charge/components/bottom_sheet_parent.dart';
import 'package:megaplug/presentation/home/pages/charge/components/charge_wallet_view.dart';
import 'package:megaplug/presentation/home/pages/charge/components/error_view.dart';
import 'package:megaplug/presentation/home/pages/charge/components/swipe_to_charge_view.dart';

import '../../../../../config/clients/api/api_result.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../controller/charge_controller.dart';

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
        ApiResult apiResult = chargeController.stationApiResult;
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
            ApiSuccess() => SwipeToChargeView(
              serial: serial,
            ),
            ApiFailure() => apiResult.getError().contains('balance')
                ? ChargeWalletView(balance: apiResult.getFailureData())
                : ErrorView(),
          },
        );
      },
    );
  }
}
