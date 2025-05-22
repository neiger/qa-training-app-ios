
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = MonitoringWindow(frame: UIScreen.main.bounds) // 👈 updated here
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
