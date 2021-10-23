import UIKit
import RxSwift
import RxCocoa

class StartViewController: RxViewController<StartView> {
    let viewModel = StartViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        customView.startButton.rx.tap
            .bind(to: viewModel.startTapped)
            .disposed(by: bag)
    }
}
