import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print(Bundle.main.object(forInfoDictionaryKey: "googleMapsApiKey") as? String ?? "")
        GMSServices.provideAPIKey(Bundle.main.object(forInfoDictionaryKey: "googleMapsApiKey") as? String ?? "")
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
