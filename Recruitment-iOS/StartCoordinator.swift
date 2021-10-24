import UIKit
import Rswift
import RxSwift

class StartCoordinator: Coordinator {
    private let navigationController = UINavigationController()
    private var bag = DisposeBag()
    let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        super.init()
        setupBindings()
    }

    private func setupBindings() {
        NotificationCenter.default.rx.notification(.coordinatorRestartApplication)
            .subscribe(onNext: { [weak self] _ in
                self?.childCoordinators.removeAll()
                self?.start()
            }) .disposed(by: bag)
    }

    override func start() {
        let start = R.storyboard.start.startViewController()!
        start.viewModel.coordinator = self
        window.rootViewController = start
        window.makeKeyAndVisible()
    }

    func showMenu() {
        let menuCoordinator = MenuCoordinator()
        childCoordinators.append(menuCoordinator)
        menuCoordinator.start()
        window.rootViewController = menuCoordinator.rootViewController
        window.makeKeyAndVisible()
    }
}
