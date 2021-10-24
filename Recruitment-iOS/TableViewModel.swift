import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt

class TableViewModel: ViewModel<TableViewCoordinator> {
    let isDownloading = BehaviorRelay<Bool>(value: true)
    let items = BehaviorRelay<[ItemModel]>(value: [])
    let showDetails = PublishRelay<ItemModel>()
    let restart = PublishRelay<Void>()

    override func setupBindings() {
        let networkItems = apiClient.itemsRepository.getItems().share()

        networkItems
            .mapTo(false)
            .bind(to: isDownloading)
            .disposed(by: bag)

        networkItems
            .bind(to: items)
            .disposed(by: bag)

        showDetails
            .observeOnMain()
            .subscribe(onNext: { [unowned self] in
                coordinator?.showDetails(id: $0.id, color: $0.color)
            }).disposed(by: bag)

        restart
            .observeOnMain()
            .subscribe(onNext: { [unowned self] in
                coordinator?.restartApplication()
            }).disposed(by: bag)
    }
}
