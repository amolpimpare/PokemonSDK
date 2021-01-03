//
//  BasePage.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import XCTest

class BasePage {
    static let app = XCUIApplication()
    static var buttons: XCUIElementQuery { return app.buttons }
    static var images: XCUIElementQuery { return app.images }
    static var staticTexts: XCUIElementQuery { return app.staticTexts }
    static var scrollViews: XCUIElementQuery { return app.scrollViews }
    static var textFields: XCUIElementQuery { return app.textFields }
    static var spinners: XCUIElementQuery { return app.otherElements }
    static var tables: XCUIElementQuery { return app.tables }
    static var navigationBars: XCUIElementQuery { return app.navigationBars }
}
