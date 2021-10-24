import UIKit

struct ItemsJSON: Codable {
    let data: [ItemModelJSON]
}

struct ItemModelJSON: Codable {
    struct Attributes: Codable {
        let name: String
        let preview: String
        let color: String
    }
    let id: String
    let type: String
    let attributes: Attributes
}

struct ItemModel {
    let id: Int
    let name: String
    let color: UIColor
    let preview: String
}
