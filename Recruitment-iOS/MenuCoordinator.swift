import Foundation

final class MenuCoordinator: Coordinator {
    private let menuItems: [MenuTab] = [.tableView, .collectionView]
    private let menuController = R.storyboard.menu.menuViewController()!

    override init() {
        super.init()
        rootViewController = menuController
        setupMenuItems()
    }

    private func setupMenuItems() {
        for menuItem in menuItems {
            var tabCoordinator = menuItem.createCoordinator()
            tabCoordinator.menuCoordinator = self
            tabCoordinator.start()
            tabCoordinator.rootViewController.tabBarItem = tabCoordinator.tabBarItem
            addChildCoordinator(tabCoordinator)
        }
    }

    override func start() {
        menuController.viewControllers = childCoordinators.compactMap { ($0 as? Coordinator)?.rootViewController }
        menuController.selectedIndex = 0
    }
}
