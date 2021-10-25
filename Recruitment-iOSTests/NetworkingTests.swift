import XCTest
import RxSwift
import RxTest
@testable import Recruitment_iOS

class NetworkingTests: XCTestCase {
    var networkingManager: NetworkingManager!
    var scheduler: TestScheduler!
    var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        networkingManager = .sharedManager
        scheduler = .init(initialClock: 0)
        bag = .init()
    }

    override func tearDown() {
        networkingManager = nil
        scheduler = nil
        bag = nil
        super.tearDown()
    }

    func test_fetch_success() {
        let items = scheduler.createObserver(String.self)

        networkingManager.runRequest(fileName: "Items", success: ItemsJSON.self)
            .subscribe({ event in
                switch event {
                    case .next(_):
                    items.onNext("Success")
                    default: break
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for response")], timeout: 2.0)
        XCTAssertRecordedElements(items.events, ["Success"])
    }

    func test_fetch_error() {
        let errorMessage = scheduler.createObserver(String.self)

        networkingManager.runRequest(fileName: "ItemsIncorrectName", success: ItemModelJSON.self)
            .subscribe({ event in
                switch event {
                    case .error(_):
                    errorMessage.onNext("Failure")
                    default: break
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for response")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, ["Failure"])
    }

    func test_fetch_no_file_with_name_error() {
        let errorMessage = scheduler.createObserver(JSONParserErrors.self)

        networkingManager.runRequest(fileName: "ItemsIncorrectName", success: ItemsJSON.self)
            .subscribe({ event in
                switch event {
                    case .error(let error):
                        if let error = error as? JSONParserErrors {
                            errorMessage.onNext(error)
                        }
                    default: break
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for response")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, [.noFileWithName])
    }

    func test_fetch_parsing_error() {
        let errorMessage = scheduler.createObserver(JSONParserErrors.self)

        networkingManager.runRequest(fileName: "Items", success: ItemModelJSON.self)
            .subscribe({ event in
                switch event {
                    case .error(let error):
                        if let error = error as? JSONParserErrors {
                            errorMessage.onNext(error)
                        }
                    default: break
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for response")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, [.parsingError])
    }
}
