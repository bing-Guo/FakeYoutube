import Foundation
@testable import FakeYoutubeSwift

class FakeHTTPResponse {
    func success(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func badRequest(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 400, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    func notFoundRequest(url: URL) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: 404, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
}
