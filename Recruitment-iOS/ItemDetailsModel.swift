import UIKit

struct ItemDetailsModelNetwork: Codable {
    let name: String
    let color: String
    let desc: String
}

struct ItemDetailsModel {
    let name: String
    let color: UIColor
    var desc: String
}
