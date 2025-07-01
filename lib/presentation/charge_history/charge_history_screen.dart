import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/charge_history/components/charge_history_card.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';

class ChargeHistoryScreen extends StatelessWidget {
  const ChargeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'charging_history'.tr,
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 38.0,
        ),
        child: ListView.separated(
          itemBuilder: (context, index) => ChargeHistoryCard(),
          separatorBuilder: (context, index) => 5.ph,
          itemCount: 10,
        ),
      ),
    );
  }
}
