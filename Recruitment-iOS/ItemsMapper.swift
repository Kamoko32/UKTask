import Foundation
import UIKit

protocol ItemsMapperType {
    func map(_ input: ItemModelJSON) throws -> ItemModel
    func mapDetails(_ input: ItemDetailsJSON) throws -> ItemDetailsModel
}

class ItemsMapper: ItemsMapperType {
    func map(_ input: ItemModelJSON) throws -> ItemModel {
        guard let intID = Int(input.id) else { throw DataMapperErrors.mapError("Couldn't format String to Int") }
        return .init(
            id: intID,
            name: input.attributes.name,
            color: mapStringToUIColor(input: input.attributes.color),
            preview: input.attributes.preview
        )
    }

    func mapDetails(_ input: ItemDetailsJSON) throws -> ItemDetailsModel {
        guard let intID = Int(input.data.id) else { throw DataMapperErrors.mapError("Couldn't format String to Int") }
        return .init(
            id: intID,
            name: input.data.attributes.name,
            color: mapStringToUIColor(input: input.data.attributes.color),
            desc: input.data.attributes.desc
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
