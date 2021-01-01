//
//  Pokemon.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation

/// PokemonSprites
public struct PokemonSprites: Codable {
    public var frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

/// Pokemon
public struct Pokemon: Codable {
    public var name: String
    public var sprites: PokemonSprites
}

/// Language
public struct Language: Codable {
    public var name: String
}

/// Flavor Text
public struct FlavorText: Codable {
    public var text: String
    public var language: Language
    
    enum CodingKeys: String, CodingKey {
        case text = "flavor_text"
        case language
    }
}

/// PokemonSpecies
public struct PokemonSpecies: Codable {
    public var flavorTextEntries: [FlavorText]?
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

/// ShakespeareanDescription
public struct ShakespeareanDescription: Codable {
    public var contents: Contents
    
    public struct Contents: Codable {
        public var translated: String
        public var text: String
    }
}
