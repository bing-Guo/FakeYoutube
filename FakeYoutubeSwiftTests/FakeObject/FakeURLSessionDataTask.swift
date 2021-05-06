import Foundation
@testable import FakeYoutubeSwift

class FakeURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var resumeWasCalled = false
    private (set) var cancelWasCalled = false
    
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        cancelWasCalled = true
    }
}
