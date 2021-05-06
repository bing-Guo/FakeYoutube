import Foundation

class HTTPClient {
    let session: URLSessionProtocol
    var task: URLSessionDataTaskProtocol?
    
    init(session: URLSessionProtocol) {
        self.session = session
    }
    
    func send<T: HTTPRequest>(_ request: T, handler: @escaping (Result<T.Response, ResponseError>) -> Void) {
        task?.cancel()
        
        let urlRequest = request.buildRequest()
        
        task = session.dataTaskRequest(urlRequest) { data, response, error in
            guard let data = data else {
                handler(.failure(ResponseError.nilData))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                handler(.failure(ResponseError.nonHTTPResponse))
                return
            }
            
            if response.statusCode >= 300 {
                do {
                    let error = try decoder.decode(APIError.self, from: data)
                    if response.statusCode == 400 {
                        handler(.failure(ResponseError.tokenError))
                    } else {
                        let error = ResponseError.apiError(error: error, statusCode: response.statusCode)
                        handler(.failure(error))
                    }
                    return
                } catch {
                    handler(.failure(ResponseError.unknownError(error: error)))
                    return
                }
            }
            
            do {
                let value = try decoder.decode(T.Response.self, from: data)
                handler(.success(value))
            } catch DecodingError.dataCorrupted(let context) {
                let message = "DataCorrupted: \(context.debugDescription), codingPath: \(context.codingPath)"
                handler(.failure(ResponseError.decodeError(msg: message)))
            } catch DecodingError.keyNotFound(let key, let context) {
                let message = "Key '\(key)' not found: \(context.debugDescription), codingPath: \(context.codingPath)"
                handler(.failure(ResponseError.decodeError(msg: message)))
            } catch DecodingError.valueNotFound(let value, let context) {
                let message = "Value '\(value)' not found: \(context.debugDescription), codingPath: \(context.codingPath)"
                handler(.failure(ResponseError.decodeError(msg: message)))
            } catch DecodingError.typeMismatch(let type, let context) {
                let message = "Type '\(type)' mismatch: \(context.debugDescription), codingPath: \(context.codingPath)"
                handler(.failure(ResponseError.decodeError(msg: message)))
            } catch {
                handler(.failure(ResponseError.unknownError(error: error)))
            }
        }
        
        task?.resume()
    }
}
