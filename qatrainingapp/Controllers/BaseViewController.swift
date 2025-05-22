// import UIKit
//
// class BaseViewController: UIViewController {
//    private var isAppInBackground = false
//    private var sessionTimeoutTimer: Timer?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        NotificationCenter.default.addObserver(self, selector: #selector(sessionTimeout), name: Notification.Name("SessionTimeout"), object: nil)
//
//        startSession()
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    func startSession() {
//        stopSession()
//        sessionTimeoutTimer = Timer.scheduledTimer(timeInterval: 600, target: self, selector: #selector(sessionTimeout), userInfo: nil, repeats: false)
//    }
//
//    func stopSession() {
//        sessionTimeoutTimer?.invalidate()
//        sessionTimeoutTimer = nil
//    }
//
//    @objc func sessionTimeout() {
//        // Log out logic here
//        redirectToLogin()
//    }
//
//    func redirectToLogin() {
//        // Logic for redirecting to the login screen
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        startSession()
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        stopSession()
//    }
// }
