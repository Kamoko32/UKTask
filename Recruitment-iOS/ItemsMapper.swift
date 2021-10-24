import Foundation
import UIKit

class MockItemsMapper: DataMapper {
    func map(_ input: ItemModelJSON) throws -> ItemModel {
        guard let intID = Int(input.id) else { throw DataMapperErrors.mapError("Couldnt format String to Int") }
        return .init(
            id: intID,
            name: input.attributes.name,
            color: mapStringToUIColor(input: input.attributes.color)
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
