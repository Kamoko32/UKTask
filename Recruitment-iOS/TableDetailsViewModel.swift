import RxSwift
import RxCocoa

class TableDetailsViewModel: ViewModel<TableViewCoordinator> {
    let description = BehaviorRelay<String>(value: "")
    let name = BehaviorRelay<String>(value: "")
    let backgroundColor = BehaviorRelay<UIColor>(value: .white)
    let getDetails = PublishRelay<Int>()

    override func setupBindings() {
        let details = getDetails
            .flatMapLatest { [unowned self] id in
                apiClient.itemsRepository.getItemDetails(id: id)
            }
            .share()

        details
            .mapAt(\.desc)
            .bind(to: description)
            .disposed(by: bag)

        details
            .mapAt(\.name)
            .bind(to: name)
            .disposed(by: bag)
    }
}
