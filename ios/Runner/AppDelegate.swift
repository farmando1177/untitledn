import Flutter
import UIKit
import GoogleMaps
import FirebaseCore // استيراد Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()

    // تأكد من توفير مفتاح API قبل تسجيل البقية
    GMSServices.provideAPIKey("AIzaSyCfuiVKt5_83ww3YU2b2mvw6bKp3IA22kg")
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

