import Foundation

//let ApplicationKey = ""

enum PlaylistDownloadedResult {
    case success(PlaylistItemListResponse)
    case failure(Error?)
}

class YoutubeAPIManager {
    static let shared = YoutubeAPIManager()
    
    var client = HTTPClient(session: URLSession.shared)
    
    private init() {}
    
    func fetchPlaylistItemList(playListID: String, maxCount: Int, pageToken: String?, completed: @escaping (PlaylistDownloadedResult) -> Void) {
        let request = YoutubeFetchPlaylistItemListRequest(playlistId: playListID, maxResults: maxCount, pageToken: pageToken)
        
        client.send(request) { (result: Result<PlaylistItemListResponse, ResponseError>) in
            switch result {
            case let .success(response):
                completed(PlaylistDownloadedResult.success(response))
            case let .failure(error):
                completed(PlaylistDownloadedResult.failure(error))
            }
        }
    }
}
