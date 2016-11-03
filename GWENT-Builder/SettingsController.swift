//
//  SettingsController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 10/14/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import UIKit
import SwiftyJSON
import gwentBusiness
class SettingsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Button Actions 
    
    @IBAction func deleteDataPress(_ sender: AnyObject)
    {
        //delete all cards and images from the app
        let data = GWENT_Data()
        data.deleteCards()        
    }
    @IBAction func downloadDataPress(_ sender: AnyObject)
    {
        SessionController.sharedInstance.REST.getAllCards(callback: Callback)

    }
    //MARK : Download CallBack
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
            if cantidad == 95
            {
                //se supone que ya descargamos todo y que las tarjetas ya fueron traidas
                //SessionController.sharedInstance.messageHandler.showMessage(title: "Cards", message: "Download Complete", nav: self.tabBarController!)
                debugPrint("Download Complete")
            }
        }
    }
    func downloadImages(jsonarray:JSON , object:Any)
    {
        let card = object as! Card
        card.artwork = SessionController.sharedInstance.jsonParser.getArtwork(jsonarray: jsonarray)
        let data = GWENT_Data()
        data.saveCard(card: card)
        
    }
    func CallbackHref(jsonarray:JSON)
    {
        
        let card = SessionController.sharedInstance.jsonParser.parseCard(json: jsonarray)
        //todas las cartas ya estan metidas a la lista ahora nos traemos todos los artwork
        
        SessionController.sharedInstance.REST.getArtwork(url: jsonarray["artwork"]["href"].stringValue, callback: downloadImages , card: card)
        //   debugPrint("Downloading artwork of " + card.name )
        
        
    }
    

}
