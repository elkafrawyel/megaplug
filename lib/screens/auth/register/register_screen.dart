import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../components/wavy_appbar.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WavyAppBar(
              withBackButton: true,
            ),
            AppText(
              text: 'Register Screen',
              fontSize: 30,
            )
          ],
        ),
      ),
    );
  }
}
