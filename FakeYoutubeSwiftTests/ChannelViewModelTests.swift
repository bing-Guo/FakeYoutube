import XCTest
@testable import FakeYoutubeSwift

class ChannelViewModelTests: XCTestCase {
    var viewModel: ChannelTableViewModel!
    var session: FakeURLSession!
    var client: HTTPClient!
    
    override func setUpWithError() throws {
        super.setUp()
        
        viewModel = ChannelTableViewModel()
        session = FakeURLSession()
        client = HTTPClient(session: session)
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testVM_Update_True() throws {
        let expection = expectation(description: "Query time out!")
        
        viewModel?.dataDidChangedClosure = { sections in
            expection.fulfill()
            
            if let sections = sections {
                XCTAssert(sections.count == 2)
            } else {
                XCTFail("Section should not be null.")
            }
        }
        
        // Inject fake client
        YoutubeAPIManager.shared.client = client
        
        // create fake request
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: "playListID", maxResults: 20, pageToken: "pageToken")
        
        session.data = fakeSuccessPlaylistItemData
        session.response = FakeHTTPResponse().success(url: request.url)
        session.error = nil
        
        // Action
        viewModel?.update()
        
        waitForExpectations(timeout: 40.0, handler: nil)
    }
    
    func testVM_Update_Exception() throws {
        let expection = expectation(description: "Query time out!")
        
        viewModel?.errorOccurredClosure = { message in
            expection.fulfill()
        }
        
        // Inject fake client
        YoutubeAPIManager.shared.client = client
        
        // create fake request
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: "playListID", maxResults: 20, pageToken: "pageToken")
        
        session.data = fakeNotFoundData
        session.response = FakeHTTPResponse().notFoundRequest(url: request.url)
        session.error = nil
        
        // Action
        viewModel?.update()
        
        waitForExpectations(timeout: 40.0, handler: nil)
    }

}
