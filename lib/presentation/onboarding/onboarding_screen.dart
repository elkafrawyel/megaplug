import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/res.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/clients/storage/storage_client.dart';
import '../../widgets/app_transformtion_view.dart';
import '../auth/login/login_screen.dart';
import 'data/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<OnBoardingModel> data = [];

  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    data.addAll(
      [
        OnBoardingModel(
          imagePath: Res.onboarding_1,
          headerText: 'onboarding_header_1'.tr,
          contentText: 'onboarding_content_1'.tr,
        ),
        OnBoardingModel(
          imagePath: Res.onboarding_2,
          headerText: 'onboarding_header_2'.tr,
          contentText: 'onboarding_content_2'.tr,
        ),
        OnBoardingModel(
          imagePath: Res.onboarding_3,
          headerText: 'onboarding_header_3'.tr,
          contentText: 'onboarding_content_3'.tr,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: Stack(
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: Image.asset(
              data[selectedPage].imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            start: 0,
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(24),
                ),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    Res.onboardingContentBg,
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    30.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                      child: AppText(
                        text: data[selectedPage].headerText,
                        maxLines: 3,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        centerText: true,
                      ),
                    ),
                    10.ph,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 38.0),
                      child: AppText(
                        text: data[selectedPage].contentText,
                        maxLines: 5,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        centerText: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          PositionedDirectional(
            top: kToolbarHeight,
            start: 18,
            child: Offstage(
              offstage: selectedPage == data.length - 1,
              child: GestureDetector(
                onTap: () {
                  _skipIntro();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: context.kSecondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: AppText(
                      text: 'skip'.tr,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: GestureDetector(
              onTap: () {
                if (selectedPage < data.length - 1) {
                  setState(() {
                    selectedPage++;
                  });
                } else {
                  _skipIntro();
                }
              },
              child: Stack(
                children: [
                  AppTransformationView(
                    child: SvgPicture.asset(
                      Res.onboardingArrowBg,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  PositionedDirectional(
                    end: 18,
                    bottom: 0,
                    top: 18,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          PositionedDirectional(
            start: 10,
            bottom: 60,
            child: Directionality(
              textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Row(
                  children: data
                      .map(
                        (element) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPage = data.indexOf(element);
                            });
                          },
                          child: selectedPage == data.indexOf(element)
                              ? Container(
                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                  width: 25,
                                  height: 5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: context.kPrimaryColor),
                                )
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black,
                                  ),
                                ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _skipIntro() async {
    await StorageClient().save(StorageClientKeys.intro, 1);
    Get.offAll(() => LoginScreen());
  }
}
