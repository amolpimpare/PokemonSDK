//
//  HTTPWebService.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation
import Combine

/// HTTP Request paramters
public typealias Parameters = [String: Any]

/// HTTP request headers like `["Content-Type": "application/json"]`
public typealias HTTPHeaders = [String: String]

/// HTTP Request method
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

/// Define Webservice requirements
public protocol HTTPWebService {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension HTTPWebService {
    
    /// TODO: - Improve error handling
    /// Performs webservice call with given endpoint and info
    /// - Parameters:
    ///   - endpoint: service endpoint
    ///   - method: HTTP Method such as `GET`, `POST` etc
    ///   - headers: HTTP Request headers
    ///   - parameters: request parameters
    ///   - body: body parameter
    /// - Returns: AnyPublisher<Value, Error> with `Value` is decodable object  and `Errror` is  HTTPError
    func call<Value>(endpoint: APICall,
                     method: HTTPMethod = .get,
                     headers: HTTPHeaders = ["Content-Type": "application/json"],
                     parameters: Parameters? = nil,
                     body: Data? = nil) -> AnyPublisher<Value, Error> where Value: Decodable {
        do {
            let request = try endpoint.buildUrlRequest(baseURL: baseURL,
                                                       method: method,
                                                       headers: headers,
                                                       parameters: parameters,
                                                       body: body)
            return session
                .dataTaskPublisher(for: request)
                .tryMap {
                    return $0.data
            }
            .mapError { (error) -> Error in
                return HTTPError.requestFailed(error)
            }
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        } catch let error {
            return Fail<Value, Error>(error: error).eraseToAnyPublisher()
        }
    }
}
