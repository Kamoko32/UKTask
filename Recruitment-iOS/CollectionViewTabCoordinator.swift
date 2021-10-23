import UIKit

final class CollectionViewTabCoordinator: CollectionViewCoordinator, MenuTabCoordinator {
    weak var menuCoordinator: MenuCoordinator?
    let tabBarItem: UITabBarItem = UITabBarItem(title: "Item", image: nil, tag: 1)
}
