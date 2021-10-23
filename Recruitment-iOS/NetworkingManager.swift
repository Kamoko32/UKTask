import UIKit
import RxSwift

protocol NetworkingManagerDelegate {
    func downloadedItems(_ items:[ItemModel])
    func downloadedItemDetails(_ itemDetails:ItemDetailsModel)
}

class NetworkingManager: NSObject {
    static var sharedManager = NetworkingManager()

    func runMockRequest<Success: Decodable>(fileName: String, success: Success.Type) -> Observable<Success> {
        return .create { observer in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                let result = JSONParser.jsonFromFilename(fileName, success: success)
                switch result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
