import Foundation

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    
    func dataTaskRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
