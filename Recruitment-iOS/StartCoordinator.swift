import UIKit
import Rswift

class StartCoordinator: Coordinator {
    private let navigationController = UINavigationController()

    override init() {
        super.init()
        rootViewController = navigationController
    }

    override func start() {
        let start = R.storyboard.start.startViewController()!
        start.viewModel.coordinator = self
        navigationController.viewControllers = [start]
    }

    func showMenu() {}
}
