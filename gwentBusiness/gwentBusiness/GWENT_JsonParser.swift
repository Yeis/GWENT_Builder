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
        return Card(_name: json["name"].stringValue, _artwork: [String](), _faction: json["faction"]["name"].stringValue, _rarity: json["rarity"]["name"].stringValue, _subtypes: parseSubtypesArray(jsonarray: json["subtypes"]), _rows: parseRowsArray(jsonarray: json["rows"]) ,  _text: json["text"].stringValue, _type: json["type"]["name"].stringValue , _cover: "")
    }
    
    public func getArtwork(jsonarray:JSON)->[String]
    {
       // debugPrint(jsonarray)
        let rest = REST_Business()
        var stringArray =  [String]()
        rest.DownloadImage(url: jsonarray["artwork"]["normal_size"].stringValue, callback: callbackNormalArtWork)
        let range = jsonarray["artwork"]["normal_size"].stringValue.index(jsonarray["artwork"]["normal_size"].stringValue.startIndex, offsetBy: 31)
        stringArray.append(jsonarray["artwork"]["normal_size"].stringValue.substring(from: range))
        
        for item in jsonarray["alternatives"].arrayValue
        {
              rest.DownloadImage(url: item["normal_size"].stringValue, callback: callbackAlternativeArtWork)
               stringArray.append(item["normal_size"].stringValue.substring(from: range))
        }
        return stringArray
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
    func callbackAlternativeArtWork(jsonarray:JSON)
    {
        debugPrint("Completed downloading ALternative Artwork")
    }
    func callbackNormalArtWork(jsonarray:JSON)
    {
        debugPrint("Completed downloading Normal Artwork")
    }
    
}
