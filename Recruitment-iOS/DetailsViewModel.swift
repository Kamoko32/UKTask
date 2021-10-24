import RxSwift
import RxCocoa

class DetailsViewModel: ViewModel<Coordinator> {
    let isDownloading = BehaviorRelay<Bool>(value: true)
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
            .map { name in
                var newTitle = ""
                for (index, letter) in name.enumerated() {
                    newTitle += index % 2 == 0 ? letter.uppercased() : letter.lowercased()
                }
                return newTitle
            }
            .bind(to: name)
            .disposed(by: bag)

        details
            .mapTo(false)
            .bind(to: isDownloading)
            .disposed(by: bag)
    }
}
