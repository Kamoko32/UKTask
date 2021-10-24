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

        networkingManager.runMockRequest(fileName: "Items", success: ItemsJSON.self)
            .subscribe(onNext: { _ in
                items.onNext("Success")
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 2.0)
        XCTAssertRecordedElements(items.events, ["Success"])
    }

    func test_fetch_error() {
        let errorMessage = scheduler.createObserver(String.self)

        networkingManager.runMockRequest(fileName: "Items-Incorrect", success: ItemsJSON.self)
            .subscribe(onError: { error in
                errorMessage.onNext("Failure")
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, ["Failure"])
    }

    func test_fetch_no_file_with_name_error() {
        let errorMessage = scheduler.createObserver(JSONParserErrors.self)

        networkingManager.runMockRequest(fileName: "Items-Incorrect", success: ItemsJSON.self)
            .subscribe(onError: { error in
                if let error = error as? JSONParserErrors {
                    errorMessage.onNext(error)
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, [.noFileWithName])
    }

    func test_fetch_parsing_error() {
        let errorMessage = scheduler.createObserver(JSONParserErrors.self)

        networkingManager.runMockRequest(fileName: "Items", success: ItemModelJSON.self)
            .subscribe(onError: { error in
                if let error = error as? JSONParserErrors {
                    errorMessage.onNext(error)
                }
            })
            .disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 2.0)
        XCTAssertRecordedElements(errorMessage.events, [.parsingError])
    }
}
