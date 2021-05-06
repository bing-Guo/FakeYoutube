import Foundation
@testable import FakeYoutubeSwift

class FakeURLSession: URLSessionProtocol {
    var dataTask = FakeURLSessionDataTask()
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    private (set) var lastURL: URL?
    
    func dataTaskRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(data, response, error)
        
        return dataTask
    }
}
