//
//  Deck.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 11/15/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation

public class Deck
{
    var name:String!
    public var Cards:[Card] = [Card]()
    
    public init(){}
    public init(_name:String)
    {
        self.name = _name
    
    }
}
