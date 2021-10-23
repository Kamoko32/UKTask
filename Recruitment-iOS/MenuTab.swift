import UIKit

protocol MenuTabCoordinator {
    var tabBarItem: UITabBarItem { get }
    var menuCoordinator: MenuCoordinator? { get set }
}

enum MenuTab {
    case tableView
    case collectionView

    func createCoordinator() -> Coordinator & MenuTabCoordinator {
        switch self {
            case .tableView: return TableViewTabCoordinator()
            case .collectionView: return CollectionViewTabCoordinator()
        }
    }
}
