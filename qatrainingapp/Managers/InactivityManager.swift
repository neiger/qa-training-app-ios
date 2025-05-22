import Foundation

class InactivityManager {
    // MARK: Internal

    static let shared: InactivityManager = .init()

    var onTimeout: (() -> Void)?

    func start() {
        reset()
    }

    func reset() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeout, repeats: false) { [weak self] _ in
            self?.onTimeout?()
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    // MARK: Private

    private var timer: Timer?
    private let timeout: TimeInterval = 300 // 5 minutes
}
