//
//  HTTPError.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

public enum HTTPError: Error, LocalizedError {
    case missingURL
    case invalidRequest
    case requestFailed(Error)
}
