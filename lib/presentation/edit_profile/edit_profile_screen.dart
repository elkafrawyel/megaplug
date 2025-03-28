import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:megaplug/config/res.dart';
import '../home/components/home_appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppbar(
        svgAssetPath: Res.homeAppBarBg,
        height: 100,
        // Custom height
        title: 'edit_profile'.tr,
        showBackButton: true,
        svgOpacity: 1.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
