import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt

class TableViewModel: ViewModel<TableViewCoordinator> {
    let items = BehaviorRelay<[ItemModel]>(value: [])

    override func setupBindings() {
        let networkItems = apiClient.itemsRepository.getItems()

        networkItems
            .bind(to: items)
            .disposed(by: bag)
    }
}
