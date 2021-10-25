import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setup(item: ItemModel) {
        titleLabel.text = item.name
        previewLabel.text = item.preview
        backgroundColor = item.color
    }
}
