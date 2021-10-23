import UIKit

final class TableViewTabCoordinator: TableViewCoordinator, MenuTabCoordinator {
    weak var menuCoordinator: MenuCoordinator?
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Item", image: nil, tag: 0)
}
