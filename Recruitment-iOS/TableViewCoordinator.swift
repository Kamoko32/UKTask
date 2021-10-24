import UIKit

class TableViewCoordinator: Coordinator {
    private let navigationController = UINavigationController()

    override init() {
        super.init()
        rootViewController = navigationController
    }

    override func start() {
        let tableViewController = R.storyboard.table.tableViewController()!
        tableViewController.viewModel.coordinator = self
        navigationController.viewControllers = [tableViewController]
    }
}
