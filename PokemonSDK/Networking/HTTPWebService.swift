//
//  HTTPWebService.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation
import Combine

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

public protocol HTTPWebService {
    var session: URLSession { get }
    var baseURL: String { get }
}

extension HTTPWebService {
    
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
