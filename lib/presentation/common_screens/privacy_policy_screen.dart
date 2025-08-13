import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../home/components/home_appbar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});

  final List<Map<String, dynamic>> _privacyPolicyData = [
    {
      'title': 'Privacy Policy',
      'description':
          "This page aims to inform users about our practices regarding the collection, use, and sharing of personal information. By using our service, you consent to the collection of information as outlined in this policy. We collect data to enhance our service and will not share your information with third parties.",
    },
    {
      'title': 'Log Data',
      'description':
          "We want to inform you that whenever you utilize our service, we collect data from your device in the event of an app issue, referred to as Log Data. This may include details such as your device's IP address, name, operating system version, usage date and time, and other statistics.",
    },
    {
      'title': 'Cookies',
      'description':
          "Our app uses cookies to enhance your experience. Cookies are small data files stored on your device that help us remember your preferences and improve our service. You can choose to accept or decline cookies through your device settings.",
    },
    {
      'title': 'Service Providers',
      'description':
          "We may employ third-party companies and individuals to facilitate our service, provide the service on our behalf, or assist us in analyzing how our service is used. These third parties may have access to your personal information, but they are obligated not to disclose or use it for any other purpose.",
    },
    {
      'title': 'Security',
      'description':
          "The security of your personal information is important to us. We strive to implement and maintain reasonable, commercially acceptable security procedures and practices appropriate to the nature of the information we store to protect it from unauthorized access, destruction, use, modification, or disclosure.",
    },
    {
      'title': 'Children’s Privacy',
      'description':
          "Our service is not intended for use by children under the age of 13. We do not knowingly collect personal information from children under 13. If you are a parent or guardian and you are aware that your child has provided us with personal information, don't hesitate to get in touch with us so we can take the appropriate steps.",
    },
    {
      'title': 'Update the Privacy Policy',
      'description':
          "We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new policy on this page. You are advised to review this policy periodically for any changes. Changes to this policy are effective when they are posted on this page.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'privacy_policy'.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            20.ph,
            Image.asset(
              Res.termsImage,
            ),
            10.ph,
            ..._privacyPolicyData.map(
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
