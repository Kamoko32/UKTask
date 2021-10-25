import XCTest
import RxSwift
import RxTest
@testable import Recruitment_iOS

class TableViewModelTests: XCTestCase {
    var mockApiClient: MockApiClient!
    var viewModel: TableViewModel!
    var scheduler: TestScheduler!
    var bag: DisposeBag!

    override func setUp() {
        super.setUp()
        mockApiClient = MockApiClient()
        viewModel = .init(apiClient: mockApiClient)
        scheduler = .init(initialClock: 0)
        bag = .init()
    }

    override func tearDown() {
        mockApiClient = nil
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
        XCTAssertRecordedElements(isDownloading.events, [false])
    }

    func test_get_items_with_error() {
        (mockApiClient.itemsRepository as! MockItemsRepository).result = .failure
        viewModel.refresh.accept(())
        XCTAssertNotNil(viewModel.error)
    }

    func test_get_items_with_success() {
        (mockApiClient.itemsRepository as! MockItemsRepository).result = .success
        viewModel.refresh.accept(())
        XCTAssertEqual(false, viewModel.items.value.isEmpty)
        XCTAssertEqual(false, viewModel.isDownloading.value)
        XCTAssertNil(viewModel.error)
    }

    func test_isDownloading() {
        let isDownloading = scheduler.createObserver(Bool.self)
        (mockApiClient.itemsRepository as! MockItemsRepository).result = .success

        viewModel.isDownloading
            .bind(to: isDownloading)
            .disposed(by: bag)

        scheduler.createColdObservable([
            .next(10, true),
            .next(20, false),
            .next(30, true)
        ])
            .bind(to: viewModel.isDownloading)
            .disposed(by: bag)

        scheduler.start()

        XCTAssertEqual(isDownloading.events, [
            .next(0, false),
            .next(10, true),
            .next(20, false),
            .next(30, true)
        ])
    }
}
