import Foundation

protocol HTTPRequest {
    associatedtype Response: Decodable
    
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
}

extension HTTPRequest {
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if method == .GET {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = parameters.map {
                URLQueryItem(name: $0.key, value: $0.value as? String)
            }
            request.url = components.url
        } else {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        }
        
        return request
    }
}
