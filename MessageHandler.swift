//
//  MessageHandler.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/28/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
public class MessageHandler
{
    
    public init(){}
    
    
    public func showError(title:String , message:String , nav:UINavigationController)
    {
        let alert = UIAlertController(title: "Error: " + title, message: message , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil ))
        
        nav.present(alert, animated: true, completion: nil)
    }
    
    
    public func showMessage(title:String , message:String , nav:UINavigationController)
    {
         let alert = UIAlertController(title:  title, message: message , preferredStyle: UIAlertControllerStyle.alert)
        
          alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil ))
        
        nav.present(alert, animated: true, completion: nil)
    }
    
}
