//
//  HTTPError.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

/// TODO: - Improve error handling by adding dffrent error code for network errors
/// Define diffrent API Errors
public enum HTTPError: Error, LocalizedError {
    case missingURL
    case invalidRequest
    case requestFailed(Error)
}
