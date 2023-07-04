import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
override func application(
_ application: UIApplication,
didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
GeneratedPluginRegistrant.register(with: self)
GMSServices.provideAPIKey("AIzaSyAr1bjx1zgSrj41lS2-M_R-wu1TkhiVT0Q")
return super.application(application, didFinishLaunchingWithOptions: launchOptions)
}
}