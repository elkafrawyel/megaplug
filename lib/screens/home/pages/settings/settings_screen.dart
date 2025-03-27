import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/language/language_model.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/screens/home/components/home_appbar.dart';

import '../../../../config/res.dart';
import '../../../../widgets/app_widgets/app_language/app_language_dialog.dart';
import '../../../../widgets/app_widgets/app_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  LanguageData? selectedLanguage;

  @override
  void initState() {
    selectedLanguage = LanguageData.selectedLanguage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: context.kBackgroundColor,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'settings'.tr,
      ),
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'about_app'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 8.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'notification'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Switch.adaptive(
                      value: true,
                      onChanged: (bool value) {},
                      activeColor: context.kPrimaryColor,
                      activeTrackColor: context.kPrimaryColor,
                      thumbColor: WidgetStatePropertyAll(Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedLanguage != null)
              GestureDetector(
                onTap: () {
                  showAppLanguageDialog(
                      context: context,
                      onLanguageChanged: (LanguageData languageData) {
                        print(languageData.name);
                        setState(() {
                          selectedLanguage = languageData;
                        });
                      });
                },
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        AppText(
                          text: 'language'.tr,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            color: context.kPrimaryColor.withValues(alpha: .3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            child: AppText(
                              text: selectedLanguage?.name ?? '',
                              color: context.kPrimaryColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'terms_and_conditions'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'privacy_policy'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'contact_us'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'rate_app'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'share_app'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 18.0,
                ),
                child: Row(
                  children: [
                    AppText(
                      text: 'delete_account'.tr,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: context.kTextColor,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: AppText(
                text: 'Version 1.0',
              ),
            ),
            150.ph,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
