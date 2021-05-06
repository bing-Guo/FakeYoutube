import Foundation

enum ResponseError: Error {
    case nilData
    case nonHTTPResponse
    case tokenError
    case apiError(error: APIError, statusCode: Int)
    case decodeError(msg: String)
    case unknownError(error: Error)
}
