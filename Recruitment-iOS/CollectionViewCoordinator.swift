import UIKit

class CollectionViewCoordinator: Coordinator {
    private let navigationController = UINavigationController()

    override init() {
        super.init()
        rootViewController = navigationController
    }

    override func start() {
        let collectionViewController = R.storyboard.collection.collectionViewController()!
        collectionViewController.viewModel.coordinator = self
        navigationController.viewControllers = [collectionViewController]
    }

//    func showDetails(id: Int, color: UIColor) {
//        let details = R.storyboard.tableDetails.tableDetailsViewController()!
//        details.viewModel.coordinator = self
//        details.viewModel.backgroundColor.accept(color)
//        details.viewModel.getDetails.accept(id)
//        navigationController.pushViewController(details, animated: true)
//    }
}
