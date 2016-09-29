//
//  HomeController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import gwentBusiness
class HomeController: UIViewController {
    
    
    
    
    @IBOutlet var cardOfTheDay: UIImageView!
    var Cards:[Card] = [Card]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Setup to change navigationbar 
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barStyle = .blackTranslucent
        // Do any additional setup after loading the view, typically from a nib.
        //SessionController.sharedInstance.REST.getCard(name: "alchemist")
        //let data = GWENT_Data()
       // data.deleteCards()
      // data.saveCard(card: Card(_name : "alchemist" , _artwork: "alchemist"))
    //  SessionController.sharedInstance.REST.getAllCards(callback: Callback)
        
        
      
        
        
        
        
        //me trae una imagen del document folder
        
      //let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
      // let image  = documentsUrl.appendingPathComponent("blue-stripes-commando_small.png")
      //  debugPrint(image)

        cardOfTheDay.image = UIImage(contentsOfFile: SessionController.sharedInstance.GetImagePath(name: "blue-stripes-commando_small.png"))
 //UIImage(
//        SessionControler.sharedInstance.REST.DownloadImage(url: "https://api.gwentapi.com/media/blue-stripes-commando_small.png", callback: callbackDownload)
    
    }
    func callbackDownload(jsonarray:JSON)
    {
        //debugPrint(jsonarray)
    }
    func Callback(jsonarray:JSON)
    {
        var cantidad :Int = 0
        for item in jsonarray["results"].arrayValue
        {
            if cantidad < 95
            {
                cantidad += 1
                SessionController.sharedInstance.REST.getHref(url: item["href"].stringValue, callback: CallbackHref)
                
            }
        }
    }
    func CallbackHref(jsonarray:JSON)
    {
        
        let card = SessionController.sharedInstance.jsonParser.parseCard(json: jsonarray)
        //todas las cartas ya estan metidas a la lista ahora nos traemos todos los artwork
       
        SessionController.sharedInstance.REST.getArtwork(url: jsonarray["artwork"]["href"].stringValue, callback: downloadImages , card: card)
            debugPrint("Donwloading artwork")
       
        
    }
    
    func downloadImages(jsonarray:JSON , object:Any)
    {
        let card = object as! Card
        card.artwork = SessionController.sharedInstance.jsonParser.getArtwork(jsonarray: jsonarray)
        debugPrint(card)
       let data = GWENT_Data()
       data.saveCard(card: card)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTestPressed(_ sender: AnyObject)
    {
        // SessionController.sharedInstance.REST.getCard(name: "alchemist" , callback: CallBackCardOfTheDay)
    }
    func loadButtons()
    {
//        let button = UIButton(type: .custom)
//        button.frame = CGRect(x: 160.0, y: 100.0, width: 50.0, height: 50.0)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.setImage(UIImage(named:"Monsters.png"), for: .normal)
//        button.addTarget(self, action: #selector(BtnPressed), for: .touchUpInside)
//        view.addSubview(button)
    }
    

    func CallBackCardOfTheDay(json:JSON)
    {
        
    }
    func BtnPressed()
    {
       print("Working")
    }
}

