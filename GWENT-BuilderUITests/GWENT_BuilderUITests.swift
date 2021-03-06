//
//  GWENT_BuilderUITests.swift
//  GWENT-BuilderUITests
//
//  Created by Jose Carlos on 9/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import XCTest

class GWENT_BuilderUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    func testLoadCardFinder()
    {
        let app = XCUIApplication()
        XCUIDevice.shared().orientation = .portrait
        app.tabBars.buttons["Card Finder"].tap()
        let collectionCells = app.collectionViews.cells.count
        XCTAssertEqual(collectionCells, 95, "found Instead \(collectionCells)")

    }
    func testCardViewer()
    {
        let app = XCUIApplication()
        let alchemistScrollView = app.scrollViews.containing(.staticText, identifier:"Alchemist").element
        alchemistScrollView.tap()
        let rarityCommonStaticText = app.staticTexts["Rarity: Common"]
        rarityCommonStaticText.swipeDown()
        rarityCommonStaticText.tap()
        alchemistScrollView.swipeUp()
        
    }
    
}
