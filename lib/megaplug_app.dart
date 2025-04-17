import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:megaplug/config/theme/color_extension.dart';
import 'package:megaplug/presentation/home/home_screen.dart';
import 'package:oktoast/oktoast.dart';

import 'config/clients/storage/storage_client.dart';
import 'config/constants.dart';
import 'config/environment.dart';
import 'config/language/language_model.dart';
import 'config/language/translation.dart';
import 'config/theme/theme_controller.dart';
import 'presentation/home/controller/home_binding.dart';
import 'presentation/splash/splash_screen.dart';
import 'widgets/app_widgets/app_focus_remover.dart';

class MegaPlug extends StatefulWidget {
  const MegaPlug({super.key});

  @override
  State<MegaPlug> createState() => _MegaPlugState();
}

class _MegaPlugState extends State<MegaPlug> {
  final ThemeController themeController = Get.put(ThemeController());

  @override
  void initState() {
    super.initState();
    // OfflineHandler.handle();
  }

  @override
  Widget build(BuildContext context) {
    String appLanguage = StorageClient().getAppLanguage();

    return Obx(
      () => AppFocusRemover(
        child: OKToast(
          child: GetMaterialApp(
            title: 'app_name'.tr,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: Constants.fontFamily,
              extensions: [themeController.appColors.value],
            ),
            debugShowCheckedModeBanner:
                Environment.appMode == AppMode.staging ||
                    Environment.appMode == AppMode.development,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            supportedLocales: LanguageData.supportedLocales,
            translations: Translation(),
            locale: Locale(appLanguage),
            fallbackLocale: Locale(appLanguage),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // initialBinding: HomeBinding(),
            // home: const HomeScreen(),
            home: const SplashScreen(),
            builder: (context, child) {
              child = EasyLoading.init()(context, child);
              EasyLoading.instance
                ..displayDuration = const Duration(milliseconds: 2000)

                ///loading circular view
                ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                ..loadingStyle = EasyLoadingStyle.custom
                ..maskType = EasyLoadingMaskType.black
                ..indicatorSize = 50.0
                ..radius = 10.0
                ..progressWidth = 3
                ..progressColor = context.kPrimaryColor
                ..textColor = context.kTextColor
                ..backgroundColor = context.kBackgroundColor
                ..indicatorColor = context.kPrimaryColor
                // ..maskColor = Colors.blue.withOpacity(0.5)
                ..textStyle = const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )
                ..userInteractions = true
                ..dismissOnTap = false;
              child = MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0),
                ),
                child: child,
              );
              return child;
            },
          ),
        ),
      ),
    );
  }
}
