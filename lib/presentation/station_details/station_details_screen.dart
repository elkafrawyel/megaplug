import 'package:flutter/material.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class StationDetailsScreen extends StatelessWidget {
  const StationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppText(text: 'Station Details'),
    );
  }
}
