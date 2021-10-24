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

    func showDetails(id: Int, color: UIColor) {
        let details = R.storyboard.tableDetails.tableDetailsViewController()!
        details.viewModel.coordinator = self
        details.viewModel.backgroundColor.accept(color)
        details.viewModel.getDetails.accept(id)
        navigationController.pushViewController(details, animated: true)
    }
}
