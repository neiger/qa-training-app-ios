import UIKit

class MonitoringWindow: UIWindow {
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        if event.allTouches?.contains(where: { $0.phase == .began }) == true {
            InactivityManager.shared.reset()
        }
    }
}
