import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/helpers/logging_helper.dart';
import 'package:megaplug/config/language/language_model.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/common_screens/about_us_screen.dart';
import 'package:megaplug/presentation/common_screens/contact_info_screen.dart';
import 'package:megaplug/presentation/common_screens/contact_us_screen.dart';
import 'package:megaplug/widgets/delete_account_popup.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../config/res.dart';
import '../../../../widgets/app_widgets/app_language/app_language_dialog.dart';
import '../../../../widgets/app_widgets/app_modal_bottom_sheet.dart';
import '../../../../widgets/app_widgets/app_text.dart';
import '../../../common_screens/privacy_policy_screen.dart';
import '../../../common_screens/terms_and_conditions_screen.dart';
import '../../components/home_appbar.dart';
import '../stations/controller/stations_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin {
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
            40.ph,
            GestureDetector(
              onTap: () {
                Get.to(() => AboutUsScreen());
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
                    vertical: 18.0,
                  ),
                  child: Row(
                    children: [
                      AppText(
                        text: 'about_us'.tr,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: context.kTextColor,
                        size: 16,
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
                      value: StorageClient().get(StorageClientKeys.notifications) ?? true,
                      onChanged: (bool value) async {
                        Get.find<StationsController>().showComingSoonDialog(context);
                        // await StorageClient().save(StorageClientKeys.notifications, value);
                        // setState(() {});
                      },
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
                  Get.find<StationsController>().showComingSoonDialog(context);

                  // showAppLanguageDialog(
                  //     context: context,
                  //     onLanguageChanged: (LanguageData languageData) async {
                  //       AppLogger.log(languageData.name);
                  //       setState(() {
                  //         selectedLanguage = languageData;
                  //       });
                  //     });
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
            GestureDetector(
              onTap: () {
                Get.to(() => TermsAndConditionsScreen());
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
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => PrivacyPolicyScreen());
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
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ContactUsScreen());
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
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => ContactInfoScreen());
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
                    vertical: 18.0,
                  ),
                  child: Row(
                    children: [
                      AppText(
                        text: 'contact_info'.tr,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: context.kTextColor,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Card(
            //   elevation: 0.0,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 18.0,
            //       vertical: 18.0,
            //     ),
            //     child: Row(
            //       children: [
            //         AppText(
            //           text: 'rate_app'.tr,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         Spacer(),
            //         Icon(
            //           Icons.arrow_forward_ios,
            //           color: context.kTextColor,
            //           size: 20,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // Card(
            //   elevation: 0.0,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   color: Colors.white,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 18.0,
            //       vertical: 18.0,
            //     ),
            //     child: Row(
            //       children: [
            //         AppText(
            //           text: 'share_app'.tr,
            //           fontSize: 13,
            //           fontWeight: FontWeight.w500,
            //         ),
            //         Spacer(),
            //         Icon(
            //           Icons.arrow_forward_ios,
            //           color: context.kTextColor,
            //           size: 20,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  Get.find<StationsController>().showComingSoonDialog(context);

                  // showAppModalBottomSheet(
                  //   context: context,
                  //   child: DeleteAccountPopup(),
                  // );
                },
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
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Center(
            //   child: FutureBuilder(
            //     future: PackageInfo.fromPlatform(),
            //     builder: (context, asyncSnapshot) {
            //       return asyncSnapshot.data == null
            //           ? SizedBox()
            //           : AppText(
            //               text: 'Version ${asyncSnapshot.data?.version}',
            //             );
            //     },
            //   ),
            // ),
            150.ph,
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
