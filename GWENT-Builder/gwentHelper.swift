//
//  gwentHelper.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 10/13/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import CoreData
import gwentBusiness
public class gwentHelper
{
    private var artworksHelper:[String] = [String]()
    private var subtypesHelper:[String] = [String]()
    private var rowsHelper:[String] = [String]()
    
    public init(){}
    
    
    public func getlocalCard(item:NSManagedObject)->Card
    {
        //verify that the helper are empty
        artworksHelper.removeAll()
        rowsHelper.removeAll()
        subtypesHelper.removeAll()
        
        let artworkSet = item.mutableSetValue(forKey: "artworks")
        let subtypeSet = item.mutableSetValue(forKey: "subtypes")
        let rowSet = item.mutableSetValue(forKey: "rows")
        artworkSet.forEach(procesarArtwork)
        subtypeSet.forEach(procesarSubtypes)
        rowSet.forEach(procesarRows)
        
        return Card(_name: item.value(forKey: "name") as! String, _artwork: artworksHelper, _faction: item.value(forKey: "faction") as! String, _rarity: item.value(forKey: "rarity") as! String, _subtypes: subtypesHelper, _rows: rowsHelper, _text: item.value(forKey: "text") as! String, _type: item.value(forKey: "type") as! String , _cover: artworksHelper[0])
        
      


    }
    //helper functions
    func procesarArtwork(art:Any)
    {
        let _art =  art as! NSManagedObject
        artworksHelper.append(_art.value(forKey: "imagePath") as! String)
    }
    func procesarRows(row:Any)
    {
        let _row =  row as! NSManagedObject
        rowsHelper.append(_row.value(forKey: "name") as! String)
    }
    func procesarSubtypes(sub:Any)
    {
        let _sub =  sub as! NSManagedObject
        subtypesHelper.append(_sub.value(forKey: "name") as! String)
    }

    
}
