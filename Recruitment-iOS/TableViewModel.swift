import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt

class TableViewModel: ViewModel<TableViewCoordinator> {
    let items = BehaviorRelay<[ItemModel]>(value: [])
    let showDetails = PublishRelay<ItemModel>()

    override func setupBindings() {
        let networkItems = apiClient.itemsRepository.getItems()

        networkItems
            .bind(to: items)
            .disposed(by: bag)

        showDetails
            .observeOnMain()
            .subscribe(onNext: { [unowned self] in
                coordinator?.showDetails(id: $0.id, color: $0.color)
            }).disposed(by: bag)
    }
}
