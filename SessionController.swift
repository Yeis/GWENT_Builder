//
//  SessionController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import gwentBusiness


class SessionController
{
    public init(){}
    //Variables
    static let sharedInstance = SessionController()
    var REST:REST_Business = REST_Business()
    var jsonParser:GWENT_JsonParser = GWENT_JsonParser()
    var messageHandler:MessageHandler = MessageHandler()
    
    
    
    //Session Variables 
    var searchingOptions:[Option] = [Option]()
    
    public func GetImagePath(name:String) -> String
    {
        //pruebs de obtener imagen
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if paths.count > 0
        {
            if let dirPath = paths[0] as String?
            {
                return dirPath + "/" + name
                
                // Do whatever you want with the image
            }
        }
        return ""
    }
    public func fillOptions()
    {
        //funcion que se encarga de setear los valores de searchingOptions
        for item in type.allValues
        {
            searchingOptions.append(Option(_name: item.description))
        }
        for item in faction.allValues
        {
            searchingOptions.append(Option(_name: item.description))
        }
        for item in row.allValues
        {
            searchingOptions.append(Option(_name: item.description))
        }
    }
    
    
}
