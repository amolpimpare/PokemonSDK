//
//  TranslatorWebService.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation
import Combine

public protocol TranslatorWebRepository {
    func translate(_ text: String) -> AnyPublisher<ShakespeareanDescription, Error>
}

public struct TranslatorWebService: HTTPWebService {
    public enum API: APICall {
        case translate
        
        var path: String {
            switch self {
            case .translate:
                return "/translate/shakespeare.json"
            }
        }
    }
    
    
    public var baseURL: String = "https://api.funtranslations.com"
    public var session: URLSession
}

extension TranslatorWebService: TranslatorWebRepository {
    public func translate(_ text: String) -> AnyPublisher<ShakespeareanDescription, Error> {
        call(endpoint: API.translate, parameters: ["text": text] )
    }
}
