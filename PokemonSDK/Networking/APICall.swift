//
//  APICall.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

protocol APICall {
    var path: String { get }
}

extension APICall {
    
    public func buildUrlRequest(baseURL: String,
                                method: HTTPMethod = .get,
                                headers: HTTPHeaders = ["Content-Type": "application/json"],
                                parameters: Parameters? = nil,
                                body: Data? = nil) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw HTTPError.invalidRequest
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        /// Request Headers
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        if let params = parameters {
            try encode(&request, with: params)
        }
        
        /// Request body
        request.httpBody = body
        
        return request
    }
    
    private func encode(_ request: inout URLRequest, with queryParams: Parameters) throws {
        guard let url = request.url else {
            throw HTTPError.missingURL
        }
        
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            queryParams.isEmpty == false else {
                return
        }
        
        var queryItems = [URLQueryItem]()
        for (key, value) in queryParams {
            let percentEncodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let queryItem = URLQueryItem(name: key, value: percentEncodedValue)
            queryItems.append(queryItem)
        }
        
        urlComponents.queryItems = queryItems
        request.url = urlComponents.url
    }
}
