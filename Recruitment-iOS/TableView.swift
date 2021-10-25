import UIKit

class TableView: UIView {
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(R.nib.tableViewCell)
        tableView.refreshControl = refreshControl
    }
}
