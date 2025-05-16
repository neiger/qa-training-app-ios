
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = MonitoringWindow(frame: UIScreen.main.bounds) // 👈 updated here
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
