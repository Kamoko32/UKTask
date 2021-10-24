import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func setup(item: ItemModel) {
        self.titleLabel.text = item.name
        backgroundColor = item.color
    }
}
