import UIKit

class TableViewController: RxViewController<TableView> {

    let viewModel = TableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackButton()
        setupBindings()
        self.title = "List"
    }

    private func setupBindings() {
        viewModel.items
            .bind(to: customView.tableView.rx.items(
                cellIdentifier: R.reuseIdentifier.tableViewCell.identifier,
                cellType: TableViewCell.self)
            ) { _, item, cell in
                cell.setup(item: item)
            }.disposed(by: bag)

        customView.tableView.rx.modelSelected(ItemModel.self)
            .bind(to: viewModel.showDetails)
            .disposed(by: bag)

        viewModel.isDownloading.observeOnMain()
            .subscribe(onNext: { [weak self] isDownloading in
                isDownloading ? self?.showIndicator() : self?.hideIndicator()
            }).disposed(by: bag)
    }

    private func addBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = backButton
        backButton.rx.tap.bind(to: viewModel.restart).disposed(by: bag)
    }
}
