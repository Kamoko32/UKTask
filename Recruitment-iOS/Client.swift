import Foundation

protocol Client {
    var itemsRepository: ItemsRepositoryType { get set }
}

class ApiClient: Client {
    static var shared = ApiClient()
    var itemsRepository: ItemsRepositoryType = ItemsRepository(mapper: ItemsMapper())
}
