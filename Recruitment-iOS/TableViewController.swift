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
            .observeOnMain()
            .bind(to: customView.tableView.rx.items(cellIdentifier: R.reuseIdentifier.itemCell.identifier)) { _, item, cell in
            cell.backgroundColor = item.color
            cell.textLabel?.text = item.name
        }.disposed(by: bag)
    }

    private func addBackButton() {
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = backButton
    }
}
