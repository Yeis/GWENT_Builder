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
    public func getCard( name:String , callback: ((JSON)->Void)?)
    {
     
        self.alamoFireManager?.request("https://api.gwentapi.com/v0/cards/" + name ).responseJSON{    response  in
                self.responseCallBack(response: response.response, result: response.result, callBack: callback)
            }
    }
    public func getHref( url:String , callback: ((JSON)->Void)?)
    {
        
        self.alamoFireManager?.request(url).responseJSON{    response  in
            self.responseCallBack(response: response.response, result: response.result, callBack: callback)
        }
    }
    public func getArtwork( url:String , callback: ((JSON , Any)->Void)? , card:Card)
    {
        
        self.alamoFireManager?.request(url).responseJSON{    response  in
            self.responseCallBackAny(response: response.response, result: response.result, callBack: callback  , object: card)
        }
    }
    public func getAllCards(callback: ((JSON)->Void)?)
    {
        
        self.alamoFireManager?.request("https://api.gwentapi.com/v0/cards/?limit=95" ).responseJSON{    response  in
            self.responseCallBack(response: response.response, result: response.result, callBack: callback)
        }
    }
  
    public func DownloadImage(url:String , callback:((JSON)->Void)?)
    {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        Alamofire.download(url, to: destination).responseJSON
            { response in
                self.responseCallBack(response: response.response, result: response.result, callBack: callback)
        }

    }
    
    
    
    public func responseCallBack(response: HTTPURLResponse?, result:Result<Any> , callBack:((JSON)->Void)?)
    {
        if response != nil
        {
            //Success Call
            if response?.statusCode == 200
            {
                switch result {
                case .success(let data):
                  //  debugPrint(data)
                    callBack!(JSON(data))
                    break
                case .failure(let error):
                   // debugPrint(error)
                    break
                    
                }
            }
            //Bad Call
            else if response?.statusCode == 401
            {
              
            }
        }
    }
    public func responseCallBackAny(response: HTTPURLResponse?, result:Result<Any> , callBack:((JSON, Any)->Void)? , object: Any)
    {
        if response != nil
        {
            //Success Call
            if response?.statusCode == 200
            {
                switch result {
                case .success(let data):
                    //  debugPrint(data)
                    callBack!(JSON(data) , object)
                    break
                case .failure(let error):
                    // debugPrint(error)
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
