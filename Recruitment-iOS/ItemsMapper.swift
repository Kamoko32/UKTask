import Foundation
import UIKit

class MockItemsMapper: DataMapper {
    func map(_ input: ItemModelNetwork) throws -> ItemModel {
        .init(
            name: input.name,
            color: mapStringToUIColor(input: input.color)
        )
    }

    func mapDetails(_ input: ItemDetailsModelNetwork) throws -> ItemDetailsModel {
        .init(
            name: input.name,
            color: mapStringToUIColor(input: input.color),
            desc: input.desc
        )
    }

    private func mapStringToUIColor(input: String) -> UIColor {
        switch input {
            case "Red": return .red
            case "Green": return .green
            case "Blue": return .blue
            case "Yellow": return .yellow
            case "Purple": return .purple
            default: return .black
        }
    }
}
