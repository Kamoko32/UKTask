import Foundation
@testable import Recruitment_iOS

class MockApiClient: Client {
    static var shared = MockApiClient()
    var itemsRepository: ItemsRepositoryType = MockItemsRepository(mapper: ItemsMapper())
}
