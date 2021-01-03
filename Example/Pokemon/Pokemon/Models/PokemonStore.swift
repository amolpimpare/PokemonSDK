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
    var shakespeareandescription: String = ""
    
    var isEmpty: Bool {
        name.isEmpty || shakespeareandescription.isEmpty
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
                self.handleError("Unable to find Pokemon named \(name)")
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
                self.handleError("Unable to find Pokemon Species named \(name)")
            }
        }, receiveValue: { pokemonSpecies in
            let defaultEntry = pokemonSpecies.flavorTextEntries?.first(where: { (flavourText) -> Bool in
                flavourText.language.name == "en"
            })
            
            if let text = defaultEntry?.text {
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
                    self.handleError("Translation service is not working. Please try again later.")
                }
            }, receiveValue: { description in
                if let translated = description.contents.translated.removingPercentEncoding {
                    self.shakespeareandescription = translated
                    print(translated)
                }

                self.isLoading = false
            })
            .store(in: &cancellables)
    }
    
    /// Hanlde Error
    /// - Parameter error: error message
    private func handleError(_ error: String) {
        self.error = error
        self.isLoading = false
    }
}
