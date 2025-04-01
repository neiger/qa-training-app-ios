//import Foundation
//
//class SessionManager {
//    static let shared = SessionManager()
//    
//    private var timeoutTimer: Timer?
//    
//    private init() {}
//
//    func startSession(timeout: TimeInterval = 600) {
//        stopSession()
//        timeoutTimer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(onSessionTimeout), userInfo: nil, repeats: false)
//    }
//
//    @objc private func onSessionTimeout() {
//        print("Sesión expirada. Redirigir al login.")
//        NotificationCenter.default.post(name: Notification.Name("SessionTimeout"), object: nil)
//    }
//
//    func stopSession() {
//        timeoutTimer?.invalidate()
//        timeoutTimer = nil
//    }
//}
//
