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
    public func GetImagePath(name:String) -> String
    {
        //pruebs de obtener imagen
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if paths.count > 0
        {
            if let dirPath = paths[0] as? String
            {
                return dirPath + "/" + name
                
                // Do whatever you want with the image
            }
        }
        return ""
    }
    
    
}
