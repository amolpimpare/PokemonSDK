//
//  PokemonAPI.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

public class PokemonAPI {
    public let session: URLSession
    
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public lazy private(set) var pokemonService = PokemonWebService(session: session)
    public lazy private(set) var translatorService = TranslatorWebService(session: session)
}
