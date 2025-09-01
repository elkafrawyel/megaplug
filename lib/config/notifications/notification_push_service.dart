// import 'dart:convert';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:megaplug/config/helpers/logging_helper.dart';
//
// /*
//   NotificationPushService
//   This service handles sending push notifications via Firebase Cloud Messaging (FCM).
//   It uses a service account for authentication and the Dio package for HTTP requests.
//
//   final fcm = FCMv1Service(
//   projectId: "ws-mp-kodepedia",
//   serviceAccountPath: "assets/ev_service_account.json",
//   );
//
// await fcm.sendNotification(
//   deviceToken: "DEVICE_FCM_TOKEN",
//   title: "Hello from v1 🚀",
//   body: "This is a v1 API push",
//   imageUrl: "https://yourdomain.com/images/promo.png",
//   data: {
//     "screen": "chat",
//     "userId": "12345",
//   },
// );
//
// */
// class NotificationPushService {
//   final String projectId;
//   final String serviceAccountPath; // Path to your service_account.json
//   final Dio _dio = Dio();
//
//   NotificationPushService({
//     required this.projectId,
//     required this.serviceAccountPath,
//   });
//
//   /// Get OAuth2 access token from service account
//   Future<String> _getAccessToken() async {
//     final serviceAccountJson = File(serviceAccountPath).readAsStringSync();
//     final accountCredentials = auth.ServiceAccountCredentials.fromJson(
//       json.decode(serviceAccountJson),
//     );
//
//     final scopes = [
//       'https://www.googleapis.com/auth/cloud-platform',
//       'https://www.googleapis.com/auth/firebase.messaging',
//     ];
//
//     final client = await auth.clientViaServiceAccount(accountCredentials, scopes);
//     final accessToken = client.credentials.accessToken.data;
//
//     client.close();
//     return accessToken;
//   }
//
//   /// Send push notification
//   Future<void> sendNotification({
//     required String deviceToken,
//     required String title,
//     required String body,
//     String? imageUrl,
//     Map<String, dynamic>? data,
//   }) async {
//     final accessToken = await _getAccessToken();
//
//     final url =
//         "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";
//
//     final payload = {
//       "message": {
//         "token": deviceToken,
//         "notification": {
//           "title": title,
//           "body": body,
//           if (imageUrl != null) "image": imageUrl,
//         },
//         "data": data ?? {},
//       }
//     };
//
//     try {
//       final response = await _dio.post(
//         url,
//         options: Options(
//           headers: {
//             "Content-Type": "application/json; UTF-8",
//             "Authorization": "Bearer $accessToken",
//           },
//         ),
//         data: payload,
//       );
//
//       AppLogger.logWithGetX("✅ Notification sent: ${response.data}");
//     } catch (e) {
//       AppLogger.logWithGetX("❌ Error sending notification: $e");
//     }
//   }
// }
