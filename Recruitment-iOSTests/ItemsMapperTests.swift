import XCTest
@testable import Recruitment_iOS

class ItemsMapperTest: XCTestCase {
    var mapper: ItemsMapper!

    override func setUp() {
        super.setUp()
        mapper = .init()
    }

    override func tearDown() {
        mapper = nil
        super.tearDown()
    }

    func test_mapper_no_throw() {
        let json: ItemModelJSON = .init(id: "1", type: "type", attributes: .init(name: "name", preview: "preview", color: "red"))
        XCTAssertNoThrow(try mapper.map(json))
    }

    func test_mapper_throw() {
        let json: ItemModelJSON = .init(id: "This Should Throw", type: "type", attributes: .init(name: "name", preview: "preview", color: "red"))
        XCTAssertThrowsError(try mapper.map(json))
    }
}
