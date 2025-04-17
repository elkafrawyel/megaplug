import 'package:flutter/material.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/components/home_appbar.dart';

import '../../config/res.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        title: 'contact_us',
        showBackButton: true,
      ),

    );
  }
}
