import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/api/api_result.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/data/api_responses/balance_response.dart';
import 'package:megaplug/presentation/home/pages/wallet/controller/wallet_controller.dart';

import '../../../../../config/clients/storage/storage_client.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(builder: (walletController) {
      return switch (walletController.balanceResult) {
        ApiStart<BalanceResponse>() => SizedBox(),
        ApiLoading<BalanceResponse>() => SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        ApiEmpty<BalanceResponse>() => SizedBox(),
        ApiSuccess<BalanceResponse>() => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  SvgPicture.asset(
                    Res.walletBackgroundIcon,
                    width: MediaQuery.sizeOf(context).width * 0.92,
                  ),
                  PositionedDirectional(
                    start: 20,
                    top: 20,
                    child: AppText(
                      text: walletController.balanceResult
                              .getData()
                              .data
                              ?.userName ??
                          '',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PositionedDirectional(
                    end: 5,
                    top: 5,
                    child: Image.asset(
                      StorageClient().isAr() ? Res.arabicLogo : Res.englishLogo,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  PositionedDirectional(
                    top: 80,
                    start: 20,
                    child: AppText(
                      text:
                          walletController.balanceResult.getData().data?.rfid ??
                              '',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PositionedDirectional(
                    start: 20,
                    bottom: 20,
                    child: SvgPicture.asset(
                      Res.walletGrayIcon,
                      width: 40,
                      height: 40,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    end: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'current_balance'.tr,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                        AppText(
                          text:
                              '${walletController.balanceResult.getData().data?.balance ?? ''} ${'egp'.tr}',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ApiFailure<BalanceResponse>() => SizedBox(
            height: 200,
            child: Center(
              child: AppText(text: walletController.balanceResult.getError()),
            ),
          ),
      };
    });
  }
}
