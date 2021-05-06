import Foundation

let decoder = JSONDecoder()

struct HTTPResponse<T: Codable> {
    let value: T?
    let response: HTTPURLResponse?
    let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) throws {
        self.value = try data.map { try decoder.decode(T.self, from: $0) }
        self.response = response as? HTTPURLResponse
        self.error = error
    }
}
