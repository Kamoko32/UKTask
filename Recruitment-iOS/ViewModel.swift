import Foundation
import RxSwift

class ViewModel<C: Coordinator> {
    public let bag = DisposeBag()
    public let apiClient: Client
    public weak var coordinator: C?

    init() {
        self.apiClient = ApiClient.shared
        setupBindings()
    }

    open func setupBindings() {}
}
