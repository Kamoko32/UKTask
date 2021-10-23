import UIKit
import RxSwift
import RxCocoa
import UIKit

protocol HasCustomView {
    associatedtype CustomView: UIView
}

class RxViewController<View: UIView>: UIViewController, HasCustomView {
    typealias CustomView = View
    let bag = DisposeBag()
}

extension HasCustomView where Self: UIViewController {
    var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
