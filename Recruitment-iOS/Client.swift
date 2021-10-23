import Foundation

protocol Client {
    var itemsRepository: ItemsRepository { get set }
}

class ApiClient: Client {
    static var shared = ApiClient()

    var itemsRepository: ItemsRepository = MockItemsRepository(mapper: MockItemsMapper())
}
