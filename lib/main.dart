import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/clients/storage/storage_client.dart';
import 'config/helpers/logging_helper.dart';
import 'config/notifications/notifications_service.dart';
import 'firebase_options.dart';
import 'megaplug_app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await StorageClient().init();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await NotificationsService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  runApp(const MegaPlug());
}

Future _firebaseBackgroundMessage(RemoteMessage remoteMessage) async {
  if (remoteMessage.notification != null) {
    AppLogger.log('Background Notification Received.');
  }
}
