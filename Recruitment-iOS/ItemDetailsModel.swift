import UIKit
struct ItemDetailsJSON: Codable {
    let data: ItemDetailsModelJSON
}

struct ItemDetailsModelJSON: Codable {
    struct Attributes: Codable {
        let name: String
        let color: String
        let desc: String
    }
    let id: String
    let type: String
    let attributes: Attributes
}

struct ItemDetailsModel {
    let id: Int
    let name: String
    let color: UIColor
    var desc: String
}
