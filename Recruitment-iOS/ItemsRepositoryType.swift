import Foundation
import RxSwift

protocol ItemsRepositoryType {
    var mapper: ItemsMapper { get set }
    func getItems() -> Observable<[ItemModel]>
    func getItemDetails(id: Int) -> Observable<ItemDetailsModel>
}

class ItemsRepository: Repository, ItemsRepositoryType {
    var mapper: ItemsMapper

    init(mapper: ItemsMapper) {
        self.mapper = mapper
    }

    func getItems() -> Observable<[ItemModel]> {
        networkingManager.runRequest(fileName: "Items", success: ItemsJSON.self)
            .map { [unowned self] result in
                do { return try result.data.compactMap { try mapper.map($0) } }
                catch let error { throw DataMapperErrors.mapError(error.localizedDescription) }
            }
    }

    func getItemDetails(id: Int) -> Observable<ItemDetailsModel> {
        networkingManager.runRequest(fileName: "Item\(id)", success: ItemDetailsJSON.self)
            .map { [unowned self] result in
                do { return try mapper.mapDetails(result) }
                catch let error { throw DataMapperErrors.mapError(error.localizedDescription) }
            }
    }
}
