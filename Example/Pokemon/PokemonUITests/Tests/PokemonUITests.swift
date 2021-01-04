//
//  PokemonUITests.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import XCTest

class PokemonUITests: XCTestCase {
    
    private let searchPage = SearchPage()
    private let detailsPage = DetailsPage()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launch()
        
        expect(searchPage.table)
    }
    
    func test001_ClearButton() throws {
        XCTAssertTrue(searchPage.searchField.exists)
        XCTAssertTrue(searchPage.magnifyingGlass.exists)
        XCTAssertFalse(searchPage.clearButton.exists)
        
        searchPage.searchField.checkIsHittableAndTap()
        searchPage.searchField.typeText("pikachu")
        if let value = searchPage.searchField.value as? String {
            XCTAssertEqual(value, "pikachu")
        }
        
        searchPage.clearButton.checkIsHittableAndTap()
        if let value = searchPage.searchField.value as? String {
            XCTAssertEqual(value, "Search Pokemon...")
        }
    }
    
    func test002_Search() throws {
        XCTAssertFalse(searchPage.spinner.exists)
        
        XCTAssertTrue(searchPage.searchField.exists)
        searchPage.searchField.checkIsHittableAndTap()
        searchPage.searchField.typeText("test")
        if let value = searchPage.searchField.value as? String {
            XCTAssertEqual(value, "test")
        }
        
        searchPage.searchField.typeText("\n")
        expect(searchPage.errorLabel)
        XCTAssertEqual(searchPage.errorLabel.label, "Unable to find Pokemon named test")
        XCTAssertTrue(searchPage.clearButton.exists)
        searchPage.clearButton.checkIsHittableAndTap()
        searchPage.searchField.checkIsHittableAndTap()
        
        searchPage.searchField.typeText("pikachu")
        searchPage.searchField.typeText("\n")
        expect(searchPage.spinner,toExist: false)
        XCTAssertFalse(searchPage.errorLabel.exists)
        XCTAssertEqual(searchPage.table.cells.count, 2)
        XCTAssertEqual(searchPage.searchResultCell.label, "Pikachu")
    }
    
    func test003_AddToFavorites() throws {
        XCTAssertTrue(searchPage.searchField.exists)
        searchPage.searchField.checkIsHittableAndTap()
        searchPage.searchField.typeText("wartortle\n")
        expect(searchPage.spinner,toExist: false)
        XCTAssertFalse(searchPage.errorLabel.exists)
        XCTAssertEqual(searchPage.searchResultCell.label, "Wartortle")
        
        searchPage.searchResultCell.press(forDuration: 2)
        
        expect(searchPage.addToFavroiteButton)
        searchPage.addToFavroiteButton.checkIsHittableAndTap()
        expect(searchPage.favoritesSection)
        XCTAssertEqual(searchPage.favoritesSection.label, "FAVORITES")
        XCTAssertEqual(searchPage.table.cells.count, 3)
    }
    
    func test004_Details() throws {
        expect(searchPage.favoritesSection)
        XCTAssertEqual(searchPage.table.cells.count, 3)
        
        let favoriteCell = searchPage.table.cells.element(boundBy: 2)
        XCTAssertEqual(favoriteCell.label, "Wartortle")
        favoriteCell.checkIsHittableAndTap()
        expect(detailsPage.backButton)
        XCTAssertTrue(detailsPage.nameLabel.exists)
        XCTAssertEqual(detailsPage.nameLabel.label, "Wartortle")
        
        XCTAssertTrue(detailsPage.descLabel.exists)        
        detailsPage.backButton.checkIsHittableAndTap()
    }
}
