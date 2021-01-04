//
//  DetailsPage.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 04/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import Foundation
import PokemonSDK

class DetailsPage: BasePage {
    let nameLabel = staticTexts[PokemonSDK.DetailsView.AccessibilityIdentifier.name]
    let descLabel = staticTexts[PokemonSDK.DetailsView.AccessibilityIdentifier.description]
    let sprite = images[PokemonSDK.DetailsView.AccessibilityIdentifier.sprite]
    
    let backButton = navigationBars.buttons["Hello!"]
}
