import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt

class CollectionViewModel: ViewModel<CollectionViewCoordinator> {
    let isDownloading = BehaviorRelay<Bool>(value: false)
    let items = BehaviorRelay<[ItemModel]>(value: [])
    
    let showDetails = PublishRelay<ItemModel>()
    let restart = PublishRelay<Void>()
    let refresh = PublishRelay<Void>()

    var error: Error?

    private let apiClient: Client

    init(apiClient: Client = ApiClient.shared) {
        self.apiClient = apiClient
    }
    
    override func setupBindings() {
        let networkItems = refresh
            .flatMapLatest { [unowned self] id in
                apiClient.itemsRepository.getItems().do(onError: { self.error = $0 }).catchErrorJustComplete()
            }
            .share()

        refresh
            .mapTo(true)
            .bind(to: isDownloading)
            .disposed(by: bag)

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
