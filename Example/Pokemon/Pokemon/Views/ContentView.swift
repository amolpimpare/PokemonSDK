//
//  ContentView.swift
//  Pokemon
//
//  Created by Amol Pimpare on 30/12/20.
//  Copyright © 2020 Amol Pimpare. All rights reserved.
//

import SwiftUI
import PokemonSDK

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: PokemonModel.favoritesfetchRequest) var favoritePokemons: FetchedResults<PokemonModel>
    @EnvironmentObject var strore: PokemonStore
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            List {
                
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass")
                        .imageScale(.large)
                    
                    TextField("Search Pokemon...", text: $searchText, onCommit:  {
                        self.searchPokemon(searchText)
                    })
                    .keyboardType(.webSearch)
                    
                    if searchText.isEmpty == false {
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing)
                        }
                    }
                }
                
                if strore.isLoading {
                    HStack {
                        Spacer()
                        Spinner(isAnimating: true, style: .large, color: .gray).frame(width: 100, height: 100, alignment: .center)
                        Spacer()
                    }
                    
                } else {
                    
                    if let error = strore.error {
                        Text("\(error)")
                        
                    } else {
                        if strore.isEmpty {
                            Text("")
                        } else {
                            let name = strore.name
                            let desc = strore.shakespeareandescription
                            let sprite = strore.sprite
                            NavigationLink(destination: PokemonSDK.DetailsView(name: name, sprite: sprite, description: desc)) {
                                PokemonRow(isFavorite: strore.isFavorite, name: name, description: desc, sprite: sprite)
                            }
                        }
                    }
                    
                    if favoritePokemons.isEmpty == false {
                        Section(header: Text("Favorites")) {
                            
                            ForEach(favoritePokemons, id: \.self) { (model: PokemonModel) in
                                
                                if let name = model.name,
                                   let desc = model.shakespeareanDescription,
                                   let sprite = model.sprite {
                                    NavigationLink(destination: PokemonSDK.DetailsView(name: name, sprite: sprite, description: desc)) {
                                        PokemonRow(isFavorite: true, name: name, description: desc, sprite: sprite)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Hello!")
            .gesture(DragGesture().onChanged { _ in
                self.hideKeyboard()
            })
        }
    }
    
    /// Serach Pokemon with given name
    /// - Parameter name: pokemon name to be searched
    private func searchPokemon(_ name: String) {
        let trimmedString = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedString.isEmpty {
            return
        }
        strore.fetchPokemon(trimmedString)
    }
}
