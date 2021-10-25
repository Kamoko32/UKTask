import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    func setup(item: ItemModel) {
        titleLabel.text = item.name
        backgroundColor = item.color
    }
}
