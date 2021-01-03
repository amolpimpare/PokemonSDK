//
//  XCTestCase+Helper.swift
//  PokemonUITests
//
//  Created by Amol Pimpare on 03/01/21.
//  Copyright © 2021 Amol Pimpare. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func expect(_ element: XCUIElement, toExist exists: Bool = true) {
        setEXpecation(for: element, with: "exists == \(exists)")
    }
    
    func expect(_ element: XCUIElement, toBeHittable hittable: Bool, timeout: TimeInterval = 10) {
        setEXpecation(for: element, with: "hittable == \(hittable)", timeout: timeout)
    }
    
    func setEXpecation(for element: XCUIElement, with predicateFormat: String, timeout: TimeInterval = 10) {
        let predicate = NSPredicate(format: predicateFormat)
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: timeout)
    }
}
