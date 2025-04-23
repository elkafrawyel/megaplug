import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:megaplug/config/clients/storage/storage_client.dart';
import 'package:megaplug/config/extension/space_extension.dart';
import 'package:megaplug/config/theme/color_extension.dart';

import '../../../config/language/language_model.dart';
import '../app_text.dart';

showAppLanguageDialog({
  required BuildContext context,
  required Function(LanguageData languageData) onLanguageChanged,
}) {
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => _LanguageDialog(
      onLanguageChanged: onLanguageChanged,
    ),
  );
}

class _LanguageDialog extends StatelessWidget {
  final Function(LanguageData languageData) onLanguageChanged;

  const _LanguageDialog({required this.onLanguageChanged});

  @override
  Widget build(BuildContext context) {
    bool isAr = StorageClient().isAr();
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: StorageClient().isDarkMode()
            ? Brightness.dark
            : Brightness.light,
        scaffoldBackgroundColor: context.kBackgroundColor,
      ),
      child: CupertinoActionSheet(
        cancelButton: CupertinoButton(
          color: context.kBackgroundColor,
          onPressed: () => Navigator.pop(context),
          child: AppText(
            text: isAr ? 'إغلاق' : 'Close',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.red,
          ),
        ),
        actions: LanguageData.languageList()
            .map(
              (value) => CupertinoButton(
                color: context.kBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      // SvgPicture.asset(Res.iconLanguage),
                      Transform.scale(
                        scale: 2.5,
                        child: AppText(
                          text: value.flag,
                        ),
                      ),
                      30.pw,
                      AppText(
                        text: value.name,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: context.kTextColor,
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  await LanguageData.changeLanguage(value);
                  onLanguageChanged(value);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
