import Foundation
import RxSwift

enum JSONParserErrors: Error {
    case noFileWithName
    case parsingError
}

class JSONParser {
    static func jsonFromFilename<Success: Decodable>(_ filename: String, success: Success.Type) -> Result<Success, JSONParserErrors> {
        guard let filePath = Bundle.main.url(forResource: filename, withExtension: "json") else { return .failure(.noFileWithName) }
        do {
            let data = try Data(contentsOf: filePath)
            let decoder = JSONDecoder()
            let json = try decoder.decode(Success.self, from: data)
            return .success(json)
        } catch {
            return .failure(.parsingError)
        }
    }
}
