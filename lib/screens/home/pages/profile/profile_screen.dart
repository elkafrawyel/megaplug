import 'package:flutter/material.dart';

import '../../../../widgets/app_widgets/app_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: AppText(text: 'profile'),
    );
  }


  @override
  bool get wantKeepAlive => true;
}
