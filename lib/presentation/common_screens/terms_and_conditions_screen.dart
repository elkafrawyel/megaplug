import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';

import '../../config/res.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../home/components/home_appbar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  TermsAndConditionsScreen({super.key});

  final List<Map<String, dynamic>> _termsAndConditionsData = [
    {
      'title': 'Terms and conditions',
      'description':
          "MegaPlug provides a platform for locating electric vehicle (EV) charging stations, facilitating real-time updates, navigation, and payment options. Our service is offered free of charge; users are only responsible for the actual charging fees incurred at the charging stations. By using our service, you acknowledge that you have read and understood these terms.",
    },
    {
      'title': 'Rules and Regulations',
      'description':
          "Users must comply with all applicable laws and regulations while using our service. Any misuse, fraudulent activity, or violation of these terms may result in account suspension or termination.",
    },
    {
      'title': 'Rates and Billings',
      'description':
          "Charges for using MegaPlug services will be clearly stated within the app. All fees are subject to change, and users will be notified in advance of any modifications. Payments must be made promptly to avoid service interruptions.",
    },
    {
      'title': 'The Customer’s Duty',
      'description':
          "Users are responsible for: Providing accurate information during registration. Maintaining the confidentiality of their account credentials. Notifying MegaPlug immediately of any unauthorized use of their account.",
    },
    {
      'title': 'Our Duty',
      'description':
          "MegaPlug is committed to: Providing reliable and efficient service. Addressing user inquiries and concerns promptly. Protecting user data and privacy in accordance with our privacy policy.",
    },
    {
      'title': 'Operation and Use',
      'description':
          "Users agree to use the MegaPlug service solely for its intended purpose. Any unauthorized access, interference with service, or attempts to disrupt operations are strictly prohibited.",
    },
    {
      'title': 'Payment',
      'description':
          "Payments for services must be made through the methods specified within the app. Users are responsible for ensuring that their payment information is accurate and up to date.",
    },
    {
      'title': 'Liability',
      'description':
          "MegaPlug is not liable for any direct, indirect, incidental, or consequential damages arising from the use or inability to use our service, including but not limited to loss of data or profits.",
    },
    {
      'title': 'Term and Termination',
      'description':
          "These terms are effective until terminated by either party. Users may terminate their account at any time. MegaPlug reserves the right to suspend or terminate accounts for violations of these terms.",
    },
    {
      'title': 'Data Security',
      'description':
          "We take data security seriously and implement measures to protect user information. However, no method of transmission over the internet or electronic storage is 100% secure. Users acknowledge this risk.",
    },
    {
      'title': 'Jurisdiction and Applicable Law',
      'description':
          "These terms shall be governed by and construed per the Egyptian laws. Any disputes arising from these terms shall be resolved in the court within the Arab Republic of Egypt.",
    },
    {
      'title': 'Trademarks',
      'description':
          "All trademarks, logos, and service marks displayed in the MegaPlug service are the property of MegaPlug or its licensors. Users are not permitted to use these marks without prior written consent.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'terms_and_conditions'.tr,
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
            ..._termsAndConditionsData.map(
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
