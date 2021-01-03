//
//  XCUIElement+Helper.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import XCTest

extension XCUIElement {
    
    func checkIsHittableAndTap() {
        XCTAssertTrue(self.isHittable, "Element \(self) is not hittable")
        self.tap()
    }
}
