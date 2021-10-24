import Foundation
import RxSwift

protocol ItemsRepository {
    func getItems() -> Observable<[ItemModel]>
    func getItemWithID(id: Int) -> Observable<ItemDetailsModel>
}

class MockItemsRepository: Repository, ItemsRepository {
    let mapper: MockItemsMapper

    init(mapper: MockItemsMapper) {
        self.mapper = mapper
    }

    func getItems() -> Observable<[ItemModel]> {
        networkingManager.runMockRequest(fileName: "Items", success: ItemsJSON.self)
            .map { [weak self] result in
                do {
                    let mappedData = try result.data.compactMap { try self?.mapper.map($0) }
                    return mappedData
                } catch let error {
                    throw DataMapperErrors.mapError(error.localizedDescription)
                }
            }
    }

    func getItemWithID(id: Int) -> Observable<ItemDetailsModel> {
        networkingManager.runMockRequest(fileName: "Item\(id)", success: ItemDetailsModelNetwork.self)
            .map { [weak self] result in
                do {
                    if let mappedData = try self?.mapper.mapDetails(result) {
                        return mappedData
                    } else {
                        throw DataMapperErrors.mapError("No data")
                    }
                } catch let error {
                    throw DataMapperErrors.mapError(error.localizedDescription)
                }
            }
    }
}
