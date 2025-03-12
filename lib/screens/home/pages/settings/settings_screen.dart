import 'package:flutter/material.dart';

import '../../../../widgets/app_widgets/app_text.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: AppText(text: 'settings'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
