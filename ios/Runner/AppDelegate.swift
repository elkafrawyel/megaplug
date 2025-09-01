import Flutter
import UIKit
import GoogleMaps
import Firebase
import FirebaseMessaging
import UserNotifications


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDN_RL4wAIlysTnHLflgdZ5piV82otKeMI")
      // iOS 10+ permissions
         if #available(iOS 10.0, *) {
           UNUserNotificationCenter.current().delegate = self
           UNUserNotificationCenter.current().requestAuthorization(
             options: [.alert, .badge, .sound],
             completionHandler: { _, _ in }
           )
         } else {
           let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
           application.registerUserNotificationSettings(settings)
         }
    application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
