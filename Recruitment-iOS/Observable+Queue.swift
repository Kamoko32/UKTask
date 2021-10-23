import Foundation
import RxSwift

extension ObservableType {
    public func observeOnMain() -> Observable<Self.Element> {
        observeOn(MainScheduler.instance)
    }

    public func observeOnMainAsync() -> Observable<Self.Element> {
        observeOn(MainScheduler.asyncInstance)
    }
}
