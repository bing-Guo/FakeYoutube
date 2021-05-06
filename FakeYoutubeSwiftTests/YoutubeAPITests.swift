import XCTest
@testable import FakeYoutubeSwift

// MARK: - YoutubeAPITests
class YoutubeAPITests: XCTestCase {
    var session: FakeURLSession!
    var client: HTTPClient!
    
    override func setUpWithError() throws {
        super.setUp()
        
        session = FakeURLSession()
        client = HTTPClient(session: session)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testYoutubeAPI_FetchPlaylistItemList_True() throws {
        let expectation = self.expectation(description: "Query Time out!")
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: "playListID", maxResults: 20, pageToken: "pageToken")
        
        session.data = fakeSuccessPlaylistItemData
        session.response = FakeHTTPResponse().success(url: request.url)
        session.error = nil
        
        client.send(request) { (result: Result<PlaylistItemListResponse, ResponseError>) in
            expectation.fulfill()
            
            switch result {
            case let .success(response):
                let condition1 = (response.items.count == 2)
                let condition2 = (response.items.first?.snippet.title == "Test title 1")
                let result = condition1 && condition2
                
                XCTAssertTrue(result, "An error occurred. \nResponse: \(response).")
            case let .failure(error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 40.0, handler: nil)
    }
    
    func testYoutubeAPI_FetchPlaylistItemList_InvalidTokenException() throws {
        let expectation = self.expectation(description: "Query Time out!")
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: "playListID", maxResults: 20, pageToken: "pageToken")
        
        session.data = fakeInvalidTokenData
        session.response = FakeHTTPResponse().badRequest(url: request.url)
        session.error = nil
        
        client.send(request) { (result: Result<PlaylistItemListResponse, ResponseError>) in
            expectation.fulfill()
            
            switch result {
            case let .success(response):
                XCTFail("Get response: \(response), but expected result is tokenError.")
            case let .failure(error):
                if case ResponseError.tokenError = error {
                    XCTAssert(true)
                } else {
                    XCTFail("Get \(error), but expected result is tokenError.")
                }
            }
        }
        
        waitForExpectations(timeout: 40.0, handler: nil)
    }
    
    func testYoutubeAPI_FetchPlaylistItemList_NotFoundException() throws {
        let expectation = self.expectation(description: "Query Time out!")
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: "playListID", maxResults: 20, pageToken: "pageToken")
        
        session.data = fakeNotFoundData
        session.response = FakeHTTPResponse().notFoundRequest(url: request.url)
        session.error = nil
        
        client.send(request) { (result: Result<PlaylistItemListResponse, ResponseError>) in
            expectation.fulfill()
            
            switch result {
            case let .success(response):
                XCTFail("Get response: \(response), but expected result is tokenError.")
            case let .failure(error):
                if case let ResponseError.apiError(err, _) = error {
                    if err.error.errors.first?.reason == "playlistNotFound" {
                        XCTAssert(true)
                    } else {
                        XCTFail("Get apiError: \(err), but expected result is apiError.")
                    }
                } else {
                    XCTFail("Get \(error), but expected result is apiError.")
                }
            }
        }
        
        waitForExpectations(timeout: 40.0, handler: nil)
    }
}
