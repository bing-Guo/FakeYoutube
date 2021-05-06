import Foundation

struct APIError: Codable {
    let error: APIErrorItem
}

struct APIErrorItem: Codable {
    let code: Int
    let message: String
    let errors: [APIErrorElement]
    let status: String?
}

// MARK: - ErrorElement
struct APIErrorElement: Codable {
    let message: String
    let domain: String
    let reason: String
    let location: String?
    let locationType: String?
}
