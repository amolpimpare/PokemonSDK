//
//  PokemonStore.swift
//  Pokemon
//
//  Created by Amol Pimpare on 02/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import Foundation
import Combine
import PokemonSDK
import SwiftUI

class PokemonStore: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var error: String?
    var name: String = ""
    var sprite: String = ""
    var Shakespeareandescription: String = ""
    
    var isEmpty: Bool {
        name.isEmpty || Shakespeareandescription.isEmpty
    }
    
    @Published var isFavorite = false
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchPokemon(_ name: String) {
        self.isLoading = true
        self.error = nil
        PokemonAPI().pokemonService.fetchPokemon(name.lowercased()).sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self.error = "Unable to find Pokemon named \(name)"
                self.isLoading = false
            }
        }, receiveValue: { pokemon in
            print(pokemon.sprites)
            self.name = name.capitalized
            if let sprite = pokemon.sprites.frontDefault {
                self.sprite = sprite
            }
            self.fetchPokemonSepcies(self.name.lowercased())
        })
        .store(in: &cancellables)
    }
    
    private func fetchPokemonSepcies(_ name: String) {
        PokemonAPI().pokemonService.fetchPokemonSpecies(name).sink(receiveCompletion: { completion in
            if case .failure(let error) = completion {
                print(error.localizedDescription)
                self.error = "Unable to find Pokemon Species named \(name)"
                self.isLoading = false
            }
        }, receiveValue: { pokemonSpecies in
            let defaultEntry = pokemonSpecies.flavorTextEntries?.first(where: { (flavourText) -> Bool in
                flavourText.language.name == "en"
            })
            
            if let text = defaultEntry?.text {
                self.Shakespeareandescription = text.replacingOccurrences(of: "\n", with: " ")
                self.translate(text.replacingOccurrences(of: "\n", with: " "))
            }
        })
        .store(in: &cancellables)
    }
    
    private func translate(_ text: String) {
        PokemonAPI().translatorService.translate(text)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                    self.error = "Translation service not working. Please try again later."
                    self.isLoading = false
                }
            }, receiveValue: { description in
                self.Shakespeareandescription = description.contents.translated
                print(description.contents.translated)
                self.isLoading = false
            })
            .store(in: &cancellables)
    }
}
