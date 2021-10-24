import Foundation
import UIKit

class CollectionView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!

    enum Section {
        case all
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
    }

    private func setupCollection() {
        collectionView.collectionViewLayout = createLayout()
        collectionView.register(R.nib.collectionViewCell)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalWidth(0.5)
            )
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(20)),
            subitem: item,
            count: 2
        )
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
}
