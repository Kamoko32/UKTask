import XCTest
import RxSwift
import RxTest
@testable import Recruitment_iOS

class TableViewModelTests: XCTestCase {
    var viewModel: TableViewModel!
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

    func test_initial_values_for_downloading_and_items_count() {
        let itemsCount = scheduler.createObserver(Int.self)
        let isDownloading = scheduler.createObserver(Bool.self)

        viewModel.items
            .mapAt(\.count)
            .bind(to: itemsCount)
            .disposed(by: bag)

        viewModel.isDownloading
            .bind(to: isDownloading)
            .disposed(by: bag)

        XCTAssertRecordedElements(itemsCount.events, [0])
        XCTAssertRecordedElements(isDownloading.events, [true])
    }
}
