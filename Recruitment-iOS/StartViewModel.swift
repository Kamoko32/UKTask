import Foundation
import RxCocoa
import RxSwift

class StartViewModel: ViewModel<StartCoordinator> {
    let start = PublishRelay<Void>()

    override func setupBindings() {
        start
            .observeOnMain()
            .subscribe(onNext: { [unowned self] in
                coordinator?.showMenu()
            })
            .disposed(by: bag)
    }
}
