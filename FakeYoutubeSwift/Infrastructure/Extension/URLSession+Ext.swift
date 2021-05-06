import Foundation

extension URLSession: URLSessionProtocol {
    func dataTaskRequest(_ request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
