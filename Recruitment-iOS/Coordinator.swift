import UIKit

public protocol CoordinatorType: AnyObject {
    var childCoordinators: [CoordinatorType] { get set }
    func start()
}

class Coordinator: CoordinatorType {
    public var rootViewController: UIViewController = UIViewController()
    public var childCoordinators: [CoordinatorType] = []

    public init() { }
    public func start() { }
}

extension CoordinatorType {
    public func addChildCoordinator(_ childCoordinator: CoordinatorType) {
        childCoordinators.append(childCoordinator)
    }

    public func removeChildCoordinator(_ childCoordinator: CoordinatorType) {
        childCoordinators.removeAll(where: { $0 === childCoordinator })
    }
}
