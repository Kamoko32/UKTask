import UIKit

class TableView: UIView {
    @IBOutlet weak var tableView: UITableView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
    }

    private func setTheme() {
    }
}
