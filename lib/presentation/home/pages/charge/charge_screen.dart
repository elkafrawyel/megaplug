import 'package:flutter/material.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../stations/components/custom_marker_view.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
    );
  }

  @override
  bool get wantKeepAlive => true;
}
