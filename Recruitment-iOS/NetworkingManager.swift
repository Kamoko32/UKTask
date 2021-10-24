import UIKit
import RxSwift

protocol NetworkingManagerType {
    func runMockRequest<Success: Decodable>(fileName: String, success: Success.Type) -> Observable<Success>
}

class NetworkingManager: NSObject, NetworkingManagerType {
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
