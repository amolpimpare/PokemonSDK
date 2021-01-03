//
//  PokemonRow.swift
//  Pokemon
//
//  Created by Amol Pimpare on 02/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import SwiftUI
import PokemonSDK

struct PokemonRow: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var store: PokemonStore
    
    @State var isFavorite: Bool
    
    var name: String
    var description: String
    var sprite: String
    
    var body: some View {
        HStack {
            PokemonSDK.ImageView(withURL: sprite)
                .frame(width: 50, height: 50)
            Text(name)
            Spacer()
        }
        .contextMenu {
            if isFavorite == false {
                Button(action: {
                    addToFavorites()
                    isFavorite.toggle()
                }) {
                    Text("Add To Favorites")
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    /// This methods creates new poekemon adds saves to core data
    /// If pokemon with same name already exists, core data just merges changes
    private func addToFavorites() {
        guard store.name.isEmpty == false else {
            return
        }
        
        let newObject = PokemonModel(context: viewContext)
        newObject.isFavorite = store.isFavorite
        newObject.name = store.name
        newObject.shakespeareanDescription = store.shakespeareandescription
        newObject.sprite = sprite
        do {
            try viewContext.save()
        } catch {
            print("Error saving \(error.localizedDescription)")
        }
    }
}
