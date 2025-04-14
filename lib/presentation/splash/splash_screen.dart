import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/controller/home_binding.dart';
import 'package:megaplug/presentation/home/home_screen.dart';

import '../../config/res.dart';
import '../auth/login/login_screen.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Duration animationDuration = Duration(
    milliseconds: 3000,
  );

  _redirect() {
    bool isLoggedIn = StorageClient().isLogged();
    if (isLoggedIn) {
      Get.offAll(() => HomeScreen(), binding: HomeBinding());
      // Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => OnboardingScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(animationDuration, () => _redirect());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Res.splashBg,
            fit: BoxFit.fill,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
          ),
          Center(
              child: Image.asset(
            StorageClient().isAr() ? Res.arabicLogo : Res.englishLogo,
            width: 240,
            height: 240,
          ) // Replace with your logo asset
                  .animate()
                  .fadeIn(duration: 1000.ms)
                  .scale(duration: 1000.ms, begin: Offset(0.5, 0.5))
              // .then(delay: Duration(milliseconds: 500))
              // .shake(duration: 500.ms),
              ),
          PositionedDirectional(
            bottom: 30,
            start: 0,
            end: 0,
            child: SvgPicture.asset(
              Res.chargeIcon, // replace with your SVG path
              width: 48,
              height: 48,
            ).animate().rotate(
                  duration: animationDuration,
                ),
          )
        ],
      ),
    );
  }
}
