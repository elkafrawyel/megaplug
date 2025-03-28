import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      int? intro = StorageClient().get(StorageClientKeys.intro);

      if (intro != null && intro == 1) {
        Get.offAll(() => HomeScreen(),binding: HomeBinding());
        // Get.offAll(() => LoginScreen());
      } else {
        Get.offAll(() => OnboardingScreen());
      }
    });
    return Scaffold(
      backgroundColor: context.kPrimaryColor,
      body: Center(
        child: Image.asset(
          Res.authLogo,
          width: 240,
          height: 240,
        ) // Replace with your logo asset
            .animate()
            .fadeIn(duration: 1000.ms)
            .scale(duration: 1000.ms, begin: Offset(0.5, 0.5))
            .then(),
        // .shake(duration: 500.ms),
      ),
    );
  }
}
