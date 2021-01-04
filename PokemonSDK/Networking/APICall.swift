//
//  APICall.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

protocol APICall {
    /// endpoint path after base url
    var path: String { get }
}

extension APICall {
    
    /// Build URLRequest with given info
    /// - Parameters:
    ///   - baseURL: baseURL of the resource to be fetched
    ///   - method: HTTP Method such as `GET`, `POST` etc
    ///   - headers: HTTP Request headers
    ///   - parameters: request parameters
    ///   - body: body parameter
    /// - Throws: throws HTTPError if url is invalid, encoding failed etc
    /// - Returns: URLRequest
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
    
    /// This method creates query string and adds percent encoding to the request parameters
    /// - Parameters:
    ///   - request: request to be encoded
    ///   - queryParams: queryParams to be encoded and added to request
    /// - Throws: throws error if url is missing
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
