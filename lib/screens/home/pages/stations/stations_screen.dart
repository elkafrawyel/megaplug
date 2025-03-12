import 'package:flutter/material.dart';

import '../../../../widgets/app_widgets/app_text.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsScreenState();
}

class _StationsScreenState extends State<StationsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: AppText(text: 'stations'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
