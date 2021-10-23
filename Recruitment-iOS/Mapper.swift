import Foundation

protocol DataMapper {
    associatedtype Input: Decodable
    associatedtype Output
    func map(_ input: Input) throws -> Output
}

enum DataMapperErrors: Error {
    case mapError(String)
}
