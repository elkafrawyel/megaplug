import 'package:flutter/material.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/widgets/app_widgets/app_button.dart';
import '../app_widgets/app_text.dart';

class AppDisconnectView extends StatelessWidget {
  final Function()? retry;

  const AppDisconnectView({
    super.key,
    this.retry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Lottie.asset(Res.disconnectAnimation),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 28.0),
          child: AppText(
            text: StorageClient().isAr() ? 'تأكد من اتصالك بشبكة' : 'Please Check Internet connection',
            color: context.kHintTextColor,
            fontSize: 16,
          ),
        ),
        30.ph,
        if (retry != null)
          AppButton(
            text: StorageClient().isAr() ? 'إاعادة المحاولة' : 'Retry',
            onPressed: retry,
          ),
      ],
    );
  }
}
