//
//  GWENT_BuilderTests.swift
//  GWENT-BuilderTests
//
//  Created by Jose Carlos on 9/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import XCTest

@testable import GWENT_Builder
class GWENT_BuilderTests: XCTestCase {
    var vc:UIViewController!
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
       // vc = storyBoard.instantiateInitialViewController() as! UIViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(true)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}