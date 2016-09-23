//
//  GWENT_JsonParser.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/21/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import SwiftyJSON
public class GWENT_JsonParser
{
    
    public init(){}
    
    
    public func  parseCard(json:JSON)->Card
    {
        return Card(_name: json["name"].stringValue, _artwork: json["artwork"]["href"].stringValue, _faction: json["faction"]["name"].stringValue, _rarity: json["rarity"]["name"].stringValue, _subtypes: parseSubtypesArray(jsonarray: json["subtypes"]), _rows: parseRowsArray(jsonarray: json["rows"]) ,  _text: json["text"].stringValue, _type: json["type"]["name"].stringValue)
    }
    
    
    public func parseRowsArray(jsonarray:JSON)->[String]
    {
        var stringArray = [String]()
        for item in jsonarray.arrayValue
        {
            stringArray.append(item.stringValue)
        }
        return stringArray
    }
    public func parseSubtypesArray(jsonarray:JSON)->[String]
    {
        var stringArray = [String]()
        for item in jsonarray.arrayValue
        {
            stringArray.append(item["name"].stringValue)
        }
        return stringArray
    }
    
}
