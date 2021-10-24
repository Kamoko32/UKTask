import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: RxViewController<DetailsView> {
    let viewModel = DetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        viewModel.description
            .bind(to: customView.descriptionLabel.rx.text)
            .disposed(by: bag)

        viewModel.name
            .bind(to: rx.title)
            .disposed(by: bag)

        viewModel.backgroundColor
            .bind(to: customView.rx.backgroundColor)
            .disposed(by: bag)

        viewModel.isDownloading.observeOnMain()
            .subscribe(onNext: { [weak self] isDownloading in
                isDownloading ? self?.showIndicator() : self?.hideIndicator()
            }).disposed(by: bag)
    }
}
