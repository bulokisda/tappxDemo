import GoogleMobileAds
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var restrictRotation:UIInterfaceOrientationMask = .all // .portrait

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "privateData", ofType: "plist") {
            nsDictionary = NSDictionary(contentsOfFile: path)
            if let tappxKey = nsDictionary!["tappxKey"] as? String {
                TappxFramework.addTappxKey(tappxKey)
            } else {
                fatalError("You must set an environment variable 'tappxKey' with your own Tappx key which will be set into the privateData.plist at build time")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return restrictRotation
    }
}

