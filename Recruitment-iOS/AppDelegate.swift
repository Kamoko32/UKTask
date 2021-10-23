import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var startCoordinator: StartCoordinator?

    func applicationDidFinishLaunching(_ application: UIApplication) {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        startCoordinator = StartCoordinator(window: window)
        startCoordinator?.start()
    }
}

