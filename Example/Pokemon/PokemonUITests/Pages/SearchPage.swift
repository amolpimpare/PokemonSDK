//
//  SearchPage.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import XCTest

class SearchPage: BasePage {
    let magnifyingGlass = images["com.pokemon.search.magnifyingglass"]
    let clearButton = buttons["com.pokemon.search.button.clear"]
    let searchField = textFields["com.pokemon.search.textfiled"]
    let spinner = spinners["com.pokemon.search.spinner"]
    let errorLabel = staticTexts["com.pokemon.search.label.error"]
    let table = tables["com.pokemon.search.table"]
    let searchResultCell = tables.cells.element(boundBy: 1)
    
    let addToFavroiteButton = buttons["Add To Favorites"]
    let favoritesSection = staticTexts["FAVORITES"]
}
