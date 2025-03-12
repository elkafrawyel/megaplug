import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/register_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../../widgets/app_widgets/app_bars/wavy_appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.kBackgroundColor,

      body: SingleChildScrollView(
        child: Column(
          children: [
            RegisterAppbar(
              title: 'register'.tr,
              withBackButton: true,
            ),
            AppText(
              text: 'Register Screen',
              fontSize: 30,
            )
          ],
        ),
      ),
    );
  }
}
