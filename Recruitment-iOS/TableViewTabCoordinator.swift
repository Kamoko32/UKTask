import UIKit

final class TableViewTabCoordinator: TableViewCoordinator, MenuTabCoordinator {
    weak var menuCoordinator: MenuCoordinator?
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Table", image: nil, tag: 0)
}
