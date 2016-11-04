//
//  Card.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation

public class Card
{
    
    //Variables
    public var name:String!
    public var cover:String!
    public var artwork:[String]!
    public var faction:String!
    public var rarity:String!
    public var subtypes:[String]!
    public var rows:[String]!
    public var text:String!
    public var type:String!
    
    //mientras 
    public var quantity:Int?
    public init(){}
    
    public init(_name:String  , _artwork:[String] , _faction:String , _rarity:String , _subtypes:[String] , _rows:[String]  ,  _text:String , _type:String , _cover:String)
    {
        self.name = _name
        self.artwork = _artwork
        self.faction = _faction
        self.rarity = _rarity
        self.subtypes = _subtypes
        self.rows = _rows
        self.text = _text
        self.type = _type
        self.cover = _cover
    }
    public init(_name:String , _cover:String)
    {
        self.name = _name
        self.cover = _cover
    }
}
