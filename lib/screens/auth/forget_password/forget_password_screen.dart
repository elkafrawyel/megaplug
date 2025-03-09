import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:megaplug/widgets/app_widgets/app_text.dart';

import '../components/wavy_appbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
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
              text: 'Forget Password Screen',
              fontSize: 30,
            )
          ],
        ),
      ),
    );
  }
}
