import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class AboutUsScreen extends StatelessWidget {
  AboutUsScreen({super.key});

  final List<Map<String, dynamic>> _aboutUsData = [
    {
      'title': 'About us',
      'description':
          "MegaPlug is a cutting-edge electric vehicle (EV) charging app designed to simplify and enhance the charging experience for EV owners. Our platform connects users to a wide network of charging stations, offering real-time availability updates, navigation assistance, and seamless payment options. Whether you're at home, at work, or on the go, MegaPlug ensures you have access to the charging infrastructure you need to power your journey.",
    },
    {
      'title': 'Our Vision',
      'description':
          "Our mission is to accelerate the adoption of electric vehicles by making charging accessible, convenient, and efficient for everyone. We aim to empower EV owners with the tools and information they need to charge their vehicles confidently, ultimately contributing to a cleaner, more sustainable future.",
    },
    {
      'title': 'Our Mission',
      'description':
          "At MegaPlug, we envision a world where electric vehicles are the norm, and charging is as simple as refueling a traditional car. We strive to lead the EV charging revolution by continuously innovating our technology, expanding our network of charging stations, and providing exceptional user experiences. Together, we can create a greener planet and a more sustainable future for generations to come.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'about_us'.tr,
        showBackButton: true,
      ),
      backgroundColor: context.kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            110.ph,
            Stack(
              children: [
                Image.asset(
                  Res.logoAboutUsImage,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 38.0),
                    child: Image.asset(
                      Res.logoAboutUsImage,
                      width: 150,
                    ),
                  ),
                ),
              ],
            ),
            20.ph,
            ..._aboutUsData.map(
              (element) => Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: element['title'],
                      fontWeight: FontWeight.w500,
                    ),
                    10.ph,
                    AppText(
                      text: element['description'],
                      color: Color(0xff6C7E8E),
                      maxLines: 10,
                      fontSize: 12,
                    ),
                  ],
                ),
              ),
            ),
            20.ph,
          ],
        ),
      ),
    );
  }
}
