//
//  PokemonModel+FetchRequests.swift
//  Pokemon
//
//  Created by Amol Pimpare on 01/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import Foundation
import CoreData

extension PokemonModel {
    static var favoritesfetchRequest: NSFetchRequest<PokemonModel> {
        let request: NSFetchRequest<PokemonModel> = PokemonModel.fetchRequest()
        //request.predicate = NSPredicate(format: "isFavorite == %@", "YES")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        return request
      }
}
