import Foundation

struct YoutubeFetchPlaylistItemListRequest: HTTPRequest {
    typealias Response = PlaylistItemListResponse
    
    let url = URL(string: "https://www.googleapis.com/youtube/v3/playlistItems")!
    let method = HTTPMethod.GET
    var parameters: [String : Any] = [
        "part": "snippet,contentDetails,status",
        "key": ApplicationKey
    ]
    
    init(playlistId: String, maxResults: Int, pageToken: String?) {
        parameters["playlistId"] = playlistId
        parameters["maxResults"] = "\(maxResults)"
        
        if let token = pageToken {
            parameters["pageToken"] = "\(token)"
        }
    }
}
