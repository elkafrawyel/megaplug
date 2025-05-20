import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/res.dart';
import '../home/components/home_appbar.dart';

class HowToChargeScreen extends StatelessWidget {
  const HowToChargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'how_to_charge'.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AppText(
                text: 'Watch tutorial video for more Details',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              FlutterLogo(
                size: 200,
              ),
              AppText(
                text: 'How can i charge my electric vehicle ?',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              20.ph,
              Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.kPrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: AppText(
                        text: 'start_charging'.tr,
                        color: context.kColorOnPrimary,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
