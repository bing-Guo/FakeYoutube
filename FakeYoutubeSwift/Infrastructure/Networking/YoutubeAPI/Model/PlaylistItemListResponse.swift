import Foundation

enum ResourceType: String, Codable {
    case playlistItemListResponse = "youtube#playlistItemListResponse"
    case playlistItem = "youtube#playlistItem"
    case video = "youtube#video"
}

// MARK: - PlaylistItemListResponse
struct PlaylistItemListResponse: Codable {
    let kind: ResourceType
    let etag: String
    let nextPageToken, prevPageToken: String?
    let items: [PlaylistItem]
    let pageInfo: PageInfo
}

struct PlaylistItem: Codable {
    let kind: ResourceType
    let etag, id: String
    let snippet: PlaylistItemSnippet
    let contentDetails: PlaylistItemDetail
}

struct PlaylistItemDetail: Codable {
    let videoID: String
    let videoPublishedAt: String

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
        case videoPublishedAt
    }
}

struct PlaylistItemSnippet: Codable {
    let publishedAt: String
    let channelID: String
    let title, snippetDescription: String
    let thumbnails: Thumbnails
    let channelTitle: String
    let playlistID: String
    let position: Int
    let resourceID: ResourceID
    let videoOwnerChannelTitle: String
    let videoOwnerChannelID: String

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
        case videoOwnerChannelTitle
        case videoOwnerChannelID = "videoOwnerChannelId"
    }
}

struct ResourceID: Codable {
    let kind: ResourceType
    let videoID: String

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: thumbnailsSize
    let maxres: thumbnailsSize?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

struct thumbnailsSize: Codable {
    let url: String
    let width, height: Int
}

struct PageInfo: Codable {
    let totalResults: Int
    let resultsPerPage: Int
}
