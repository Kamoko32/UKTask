import Foundation
import RxSwift
@testable import Recruitment_iOS

class MockItemsRepository: Repository, ItemsRepositoryType {
    enum Result {
        case success
        case failure
    }

    var mapper: ItemsMapper

    public var getItemsResult: Observable<[ItemModel]> = .once([.init(id: 1, name: "MockName", color: .black, preview: "MockPreview")])
    public var getItemsDetailsResult: Observable<ItemDetailsModel> = .once(.init(id: 1, name: "MockName", color: .black, desc: "MockDescription"))
    public var result: Result = .success
    public var error: JSONParserErrors = .noFileWithName

    init(mapper: ItemsMapper) {
        self.mapper = mapper
    }

    func getItems() -> Observable<[ItemModel]> {
        switch result {
            case .success: return getItemsResult
            case .failure: return .error(error)
        }
    }

    func getItemDetails(id: Int) -> Observable<ItemDetailsModel> {
        switch result {
            case .success: return getItemsDetailsResult
            case .failure: return .error(error)
        }
    }
}
