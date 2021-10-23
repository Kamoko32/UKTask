import UIKit

class StartCoordinator: Coordinator {
    private let navigationController = UINavigationController()

    override init() {
        super.init()
        rootViewController = navigationController
    }

    override func start() {

    }
}
