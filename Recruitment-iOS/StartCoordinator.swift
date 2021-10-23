import UIKit
import Rswift

class StartCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
    }

    override func start() {
        let start = R.storyboard.start.startViewController()!
        start.viewModel.coordinator = self
        window.rootViewController = start
        window.makeKeyAndVisible()
    }

    func showMenu() {
        let menuCoordinator = MenuCoordinator()
        menuCoordinator.start()
        window.rootViewController = menuCoordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
