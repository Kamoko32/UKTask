import Foundation
import RxCocoa
import RxSwift

class StartViewModel: ViewModel<StartCoordinator> {
    let startTapped = PublishRelay<Void>()

    override func setupBindings() {
        startTapped
            .observeOnMain()
            .subscribe(onNext: { [unowned self] in
                coordinator?.showMenu()
            })
            .disposed(by: bag)
    }
}
