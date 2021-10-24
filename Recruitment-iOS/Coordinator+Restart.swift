import Foundation

extension Coordinator {
    func restartApplication() {
        NotificationCenter.default.post(name: .coordinatorRestartApplication, object: nil)
    }
}
