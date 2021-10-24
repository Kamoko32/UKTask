import XCTest
import RxSwift
import RxTest
@testable import Recruitment_iOS

class DetailsViewModelTests: XCTestCase {
    var viewModel: DetailsViewModel!
    var scheduler: TestScheduler!
    var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        viewModel = .init()
        scheduler = .init(initialClock: 0)
        bag = .init()
    }

    override func tearDown() {
        viewModel = nil
        scheduler = nil
        bag = nil
        super.tearDown()
    }

    func test_initial_values() {
        let isDownloading = scheduler.createObserver(Bool.self)
        let description = scheduler.createObserver(String.self)
        let name = scheduler.createObserver(String.self)
        let backgroundColor = scheduler.createObserver(UIColor.self)

        viewModel.isDownloading
            .bind(to: isDownloading)
            .disposed(by: bag)

        viewModel.description
            .bind(to: description)
            .disposed(by: bag)

        viewModel.name
            .bind(to: name)
            .disposed(by: bag)

        viewModel.backgroundColor
            .bind(to: backgroundColor)
            .disposed(by: bag)

        XCTAssertRecordedElements(isDownloading.events, [true])
        XCTAssertRecordedElements(description.events, [""])
        XCTAssertRecordedElements(name.events, [""])
        XCTAssertRecordedElements(backgroundColor.events, [.white])
    }

    func test_name_formatter() {
        var testPassed = true

        viewModel.getDetails.accept(1)

        viewModel.name
            .subscribe(onNext: { value in
                for (index, letter) in value.enumerated() where letter.isLetter {
                    let isValid = index % 2 == 0 ? letter.isUppercase : letter.isLowercase
                    if !isValid {
                        testPassed = false
                        break
                    }
                }
            }).disposed(by: bag)

        _ = XCTWaiter.wait(for: [expectation(description: "Wait for 2 seconds")], timeout: 2.0)
        XCTAssertTrue(testPassed)
    }
}
