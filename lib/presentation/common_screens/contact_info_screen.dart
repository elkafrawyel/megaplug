import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../config/res.dart';
import '../home/components/home_appbar.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  final List<SocialLink> socialLinks = [
    SocialLink(Res.facebookIcon, 'Facebook', ''),
    SocialLink(Res.whatsappIcon, 'Whats App', ''),
    SocialLink(Res.instagramIcon, 'Instagram', ''),
    SocialLink(Res.xIcon, 'x', ''),
    SocialLink(Res.youtubeIcon, 'Youtube', ''),
    SocialLink(Res.callIcon, 'Phone', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'contact_info'.tr,
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            110.ph,
            Image.asset(
              Res.contactUsImage,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                text: 'Contact Social information',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            30.ph,
            ...socialLinks.map(
              (element) => Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 4.0,
                ),
                child: Card(
                  elevation: 0.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 8.0,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(element.imagePath),
                        20.pw,
                        AppText(
                          text: element.text,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocialLink {
  String imagePath;
  String text;
  String link;

  SocialLink(this.imagePath, this.text, this.link);
}
