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
            .bind(to: customView.tableView.rx.items(cellIdentifier: R.reuseIdentifier.itemCell.identifier)) { _, item, cell in
                cell.backgroundColor = item.color
                cell.textLabel?.text = item.name
            }.disposed(by: bag)

        customView.tableView.rx.modelSelected(ItemModel.self)
            .bind(to: viewModel.showDetails)
            .disposed(by: bag)
    }

    private func addBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
}
