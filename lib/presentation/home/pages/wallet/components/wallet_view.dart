import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';

import '../../../../../config/clients/storage/storage_client.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                text: 'Ahmed Bakry',
                fontSize: 18,
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
              top: 70,
              start: 20,
              child: AppText(
                text: '43210097732905676',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PositionedDirectional(
              start: 20,
              bottom: 30,
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
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: 'current_balance'.tr,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  AppText(
                    text: '3.456 EGP',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
