import Alamofire
import Foundation

enum APIErrors: Error {
    case invalidURL
    case urlNotSet
    case tokenNotSet
    case couldNotDecode
}

public class SnipeIt {
    public let models: AssetModels = AssetModels()
    
    public class API {
        static let shared = API()
        
        struct Request<T: Codable> {
            var path: String
            var method: HTTPMethod
            var body: Codable?
            
            private let api = API.shared
            
            func execute() async throws -> T {
                return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<T, Error>) in
                    guard let url = api.url else {
                        continuation.resume(throwing: APIErrors.urlNotSet)
                        return
                    }
                    
                    guard let token = api.token else {
                        continuation.resume(throwing: APIErrors.tokenNotSet)
                        return
                    }
                    
                    let headers: HTTPHeaders = [
                        .authorization(bearerToken: token),
                        .accept("application/json"),
                        .contentType("application/json")
                    ]
                    
                    guard let urlPath = URL(string: url+path) else {
                        continuation.resume(throwing: APIErrors.invalidURL)
                        return
                    }
                    
                    
                    var request = URLRequest(url: urlPath)
                    request.method = method
                    request.headers = headers
                    if let body = body {
                        request.httpBody = try? JSONEncoder().encode(body)
                    }
                    
                    AF.request(request)
                        .responseDecodable(of: T.self) { response in
                        if let error = response.error {
                            continuation.resume(throwing: error)
                            return
                        }
                        
                        guard let value = response.value else {
                            continuation.resume(throwing: APIErrors.couldNotDecode)
                            return
                        }
                        
                        continuation.resume(returning: value)
                    }
                }
                
                
            }
        }
        
        var url: String?
        var token: String?
        
        public static func configure(withUrl: URL, andToken token: String) {
            API.shared.url = withUrl.absoluteString
            API.shared.token = token
        }
    }
    
    public init() {}
}
