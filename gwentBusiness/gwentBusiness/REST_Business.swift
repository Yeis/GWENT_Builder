//
//  REST_Business.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
public class REST_Business
{
    let center = NotificationCenter.default
    var alamoFireManager : Alamofire.SessionManager!
   
    
    public init()
    {
        //Timeout Configuration for messages
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10// seconds
        configuration.timeoutIntervalForResource = 10
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    public func getCard( name:String)
    {
     
        self.alamoFireManager?.request("https://api.gwentapi.com/v0/cards/" + name ).responseJSON(completionHandler: { (data) in
            debugPrint(data)
            
            })
        
    
    }
    
    public func responseCallBack(response: HTTPURLResponse?, result:Result<AnyObject> , callBack:(()->Void)?)
    {
        if response != nil
        {
            //Success Call
            if response?.statusCode == 200
            {
                switch result {
                case .success(let data):
                    debugPrint(data)
                    break
                case .failure(let error):
                    debugPrint(error)
                    break
                    
                }
            }
            //Bad Call
            else if response?.statusCode == 401
            {
              
            }
        }
    }
    
}
