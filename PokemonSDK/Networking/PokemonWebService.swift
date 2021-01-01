//
//  PokemonWebService.swift
//  PokemonSDK
//
//  Created by Amol Pimpare on 01/01/21.
//

import Foundation
import Combine

protocol PokemonWebRepository {
    func fetchPokemon(_ pokemonName: String) -> AnyPublisher<Pokemon, Error>
    func fetchPokemonSpecies(_ pokemonSpeciesName: String) -> AnyPublisher<PokemonSpecies, Error>
}

public struct PokemonWebService: HTTPWebService {
    public enum API: APICall {
        case fetchPokemonSpeciesByName(String)
        case fetchPokemonByName(String)
        
        var path: String {
            switch self {
            case .fetchPokemonByName(let name):
                return "/pokemon/\(name)"
            case .fetchPokemonSpeciesByName(let name):
                return "/pokemon-species/\(name)"
            }
        }
    }
    
    
    public var baseURL: String = "https://pokeapi.co/api/v2"
    public var session: URLSession
}

extension PokemonWebService: PokemonWebRepository {
    func fetchPokemon(_ pokemonName: String) -> AnyPublisher<Pokemon, Error> {
        call(endpoint: API.fetchPokemonByName(pokemonName))
    }
    
    func fetchPokemonSpecies(_ pokemonSpeciesName: String) -> AnyPublisher<PokemonSpecies, Error> {
        call(endpoint: API.fetchPokemonSpeciesByName(pokemonSpeciesName))
    }
}
