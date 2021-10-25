import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIRefreshControl {
    public var isRefreshing: Binder<Bool> {
        return Binder(self.base) { refreshControl, refresh in
            refresh ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
        }
    }
}
