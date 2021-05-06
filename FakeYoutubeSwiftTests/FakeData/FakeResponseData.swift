import Foundation

// MARK: - Success
let fakeSuccessPlaylistItemData = Data("""
{
    "kind": "youtube#playlistItemListResponse",
    "etag": "SDUPt3YLP3rr7aIqpR-_G9k6MAM",
    "nextPageToken": "XXXXXX",
    "items": [
        {
            "kind": "youtube#playlistItem",
            "etag": "-KfMQEH5g-8ImVdOofSd4a1kBPo",
            "id": "VVVhVklDbkRVeW9Fbkd2azBXMzhSdHlnLkVPTjV4N21VSEZN",
            "snippet": {
                "publishedAt": "2021-04-30T11:52:45Z",
                "channelId": "UCaVICnDUyoEnGvk0W38Rtyg",
                "title": "Test title 1",
                "description": "Test description 1",
                "thumbnails": {
                    "default": {
                        "url": "https://i.ytimg.com/vi/EON5x7mUHFM/default.jpg",
                        "width": 120,
                        "height": 90
                    },
                    "medium": {
                        "url": "https://i.ytimg.com/vi/EON5x7mUHFM/mqdefault.jpg",
                        "width": 320,
                        "height": 180
                    },
                    "high": {
                        "url": "https://i.ytimg.com/vi/EON5x7mUHFM/hqdefault.jpg",
                        "width": 480,
                        "height": 360
                    },
                    "standard": {
                        "url": "https://i.ytimg.com/vi/EON5x7mUHFM/sddefault.jpg",
                        "width": 640,
                        "height": 480
                    },
                    "maxres": {
                        "url": "https://i.ytimg.com/vi/EON5x7mUHFM/maxresdefault.jpg",
                        "width": 1280,
                        "height": 720
                    }
                },
                "channelTitle": "床編故事 Bad Time Stories",
                "playlistId": "UUaVICnDUyoEnGvk0W38Rtyg",
                "position": 0,
                "resourceId": {
                    "kind": "youtube#video",
                    "videoId": "EON5x7mUHFM"
                },
                "videoOwnerChannelTitle": "床編故事 Bad Time Stories",
                "videoOwnerChannelId": "UCaVICnDUyoEnGvk0W38Rtyg"
            },
            "contentDetails": {
                "videoId": "EON5x7mUHFM",
                "videoPublishedAt": "2021-04-30T12:08:29Z"
            },
            "status": {
                "privacyStatus": "public"
            }
        },
        {
            "kind": "youtube#playlistItem",
            "etag": "L3dpr0GtF4K5rbl1Mu7aXH-lA-g",
            "id": "VVVhVklDbkRVeW9Fbkd2azBXMzhSdHlnLlFQT3lIOGNpMlZZ",
            "snippet": {
                "publishedAt": "2021-04-23T02:36:59Z",
                "channelId": "UCaVICnDUyoEnGvk0W38Rtyg",
                "title": "Test title 2",
                "description": "Test description 2",
                "thumbnails": {
                    "default": {
                        "url": "https://i.ytimg.com/vi/QPOyH8ci2VY/default.jpg",
                        "width": 120,
                        "height": 90
                    },
                    "medium": {
                        "url": "https://i.ytimg.com/vi/QPOyH8ci2VY/mqdefault.jpg",
                        "width": 320,
                        "height": 180
                    },
                    "high": {
                        "url": "https://i.ytimg.com/vi/QPOyH8ci2VY/hqdefault.jpg",
                        "width": 480,
                        "height": 360
                    },
                    "standard": {
                        "url": "https://i.ytimg.com/vi/QPOyH8ci2VY/sddefault.jpg",
                        "width": 640,
                        "height": 480
                    },
                    "maxres": {
                        "url": "https://i.ytimg.com/vi/QPOyH8ci2VY/maxresdefault.jpg",
                        "width": 1280,
                        "height": 720
                    }
                },
                "channelTitle": "床編故事 Bad Time Stories",
                "playlistId": "UUaVICnDUyoEnGvk0W38Rtyg",
                "position": 1,
                "resourceId": {
                    "kind": "youtube#video",
                    "videoId": "QPOyH8ci2VY"
                },
                "videoOwnerChannelTitle": "床編故事 Bad Time Stories",
                "videoOwnerChannelId": "UCaVICnDUyoEnGvk0W38Rtyg"
            },
            "contentDetails": {
                "videoId": "QPOyH8ci2VY",
                "videoPublishedAt": "2021-04-23T10:30:02Z"
            },
            "status": {
                "privacyStatus": "public"
            }
        }
    ],
    "pageInfo": {
        "totalResults": 56,
        "resultsPerPage": 20
    }
}
""".utf8)

// MARK: - Invalid Token
let fakeInvalidTokenData = Data("""
{
    "error": {
        "code": 400,
        "message": "API key not valid. Please pass a valid API key.",
        "errors": [
            {
                "message": "API key not valid. Please pass a valid API key.",
                "domain": "global",
                "reason": "badRequest"
            }
        ],
        "status": "INVALID_ARGUMENT"
    }
}
""".utf8)

// MARK: - Not Found
let fakeNotFoundData = Data("""
{
    "error": {
        "code": 404,
        "message": "The playlist identified with the request's <code>playlistId</code> parameter cannot be found.",
        "errors": [
            {
                "message": "The playlist identified with the request's <code>playlistId</code> parameter cannot be found.",
                "domain": "youtube.playlistItem",
                "reason": "playlistNotFound",
                "location": "playlistId",
                "locationType": "parameter"
            }
        ]
    }
}
""".utf8)

