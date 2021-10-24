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
    var indicator: UIActivityIndicatorView?

    func showIndicator(style: UIActivityIndicatorView.Style = .medium, color: UIColor? = .black) {
        if indicator == nil {
            indicator = UIActivityIndicatorView()
            indicator?.style = style
            indicator?.transform = CGAffineTransform(scaleX: 2, y: 2)
            indicator?.color = color
        }
        if let indicator = indicator {
            customView.addSubview(indicator)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            customView.addConstraint(NSLayoutConstraint(
                item: indicator,
                attribute: NSLayoutConstraint.Attribute.centerX,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view,
                attribute: NSLayoutConstraint.Attribute.centerX,
                multiplier: 1,
                constant: 0)
            )
            customView.addConstraint(NSLayoutConstraint(
                item: indicator,
                attribute: NSLayoutConstraint.Attribute.centerY,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: view,
                attribute: NSLayoutConstraint.Attribute.centerY,
                multiplier: 1,
                constant: 0)
            )
            indicator.startAnimating()
        }
    }

    func hideIndicator() {
        if let indicator = indicator {
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}

extension HasCustomView where Self: UIViewController {
    var customView: CustomView {
        guard let customView = view as? CustomView else {
            fatalError("Expected view to be of type \(CustomView.self) but got \(type(of: view)) instead")
        }
        return customView
    }
}
