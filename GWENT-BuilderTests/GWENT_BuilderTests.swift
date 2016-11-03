//
//  GWENT_BuilderTests.swift
//  GWENT-BuilderTests
//
//  Created by Jose Carlos on 9/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import XCTest
import gwentBusiness

@testable import GWENT_Builder
class GWENT_BuilderTests: XCTestCase {
    var vc:UIViewController!
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
     
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
    
    func testFilterCardsType()
    {
        let data = GWENT_Data()
        let helper = gwentHelper()
        let Objects = data.loadCards()
        var Cards = [Card]()
        for item in Objects{
            Cards.append(helper.getlocalCard(item: item))
        }
        let resultTroop  = Cards.filter{ $0.type == type.Troop.description }
        let resultCharacter  = Cards.filter{ $0.type == type.Character.description }
        let resultDisloyal = Cards.filter{ $0.type == type.Disloyal.description }
        let resultHero  = Cards.filter{ $0.type == type.Hero.description }
        let resultLeader  = Cards.filter{ $0.type == type.Leader.description }
        let resultLoyal  = Cards.filter{ $0.type == type.Loyal.description }
        let resultSpecial  = Cards.filter{ $0.type == type.Special.description }
        XCTAssert(resultTroop.count > 0  , "Troop Cards Founded: \(resultTroop.count) of \(Cards.count)")
        XCTAssert(resultCharacter.count > 0  , "Character Cards Founded: \(resultCharacter.count) of \(Cards.count)")
        XCTAssert(resultDisloyal.count > 0  , "Disloyal Cards Founded: \(resultDisloyal.count) of \(Cards.count)")
        XCTAssert(resultHero.count > 0  , "Hero Cards Founded: \(resultHero.count) of \(Cards.count)")
        XCTAssert(resultLeader.count > 0  , "Leader Cards Founded: \(resultLeader.count) of \(Cards.count)")
        XCTAssert(resultLoyal.count > 0  , "Loyal Cards Founded: \(resultLoyal.count) of \(Cards.count)")
        XCTAssert(resultSpecial.count > 0  , "Special Cards Founded: \(resultSpecial.count) of \(Cards.count)")


        
    }
    
}
