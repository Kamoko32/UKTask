import RxSwift
import RxCocoa
import RxSwiftExt

class DetailsViewModel: ViewModel<Coordinator> {
    let isDownloading = BehaviorRelay<Bool>(value: true)
    let description = BehaviorRelay<String>(value: "")
    let name = BehaviorRelay<String>(value: "")
    let backgroundColor = BehaviorRelay<UIColor>(value: .white)
    let getDetails = PublishRelay<Int>()

    var error: Error?

    private let apiClient: Client

    init(apiClient: Client = ApiClient.shared) {
        self.apiClient = apiClient
    }

    override func setupBindings() {
        let details = getDetails
            .flatMapLatest { [unowned self] id in
                apiClient.itemsRepository.getItemDetails(id: id).do(onError: { self.error = $0 }).catchErrorJustComplete()
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
