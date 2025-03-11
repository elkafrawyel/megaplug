import 'package:flutter/material.dart';
import 'package:megaplug/widgets/app_widgets/app_bars/app_appbar.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../../widgets/app_widgets/app_bars/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeAppbar(
            title: 'Home Screen',
            withBackButton: true,
          ),
          AppText(
            text: 'Mega Plug',
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
