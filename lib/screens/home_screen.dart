import 'package:flutter/material.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText(
          text: 'Mega Plug',
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
