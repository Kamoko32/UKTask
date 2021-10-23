import Foundation
import RxSwift

class ViewModel<C: Coordinator> {
    public let bag = DisposeBag()
    public let apiClient = ApiClient.shared
    public weak var coordinator: C?

    init() {
        setupBindings()
    }

    open func setupBindings() {}
}
