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
import CoreData
class HomeController: UIViewController {
    
    
    @IBOutlet var lbDescription: UILabel!
    @IBOutlet var lbCardName: UILabel!
    @IBOutlet var cardOfTheDay: UIImageView!
    var Card:Card!
    var Objects:[NSManagedObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup to change navigationbar
        // get Card of the day
        let data = GWENT_Data()
        Objects = data.loadCards()
        let random = Int(arc4random_uniform(UInt32(Objects.count)))
        let helper =  gwentHelper()
        
        if Objects.count > 0 {
            Card = helper.getlocalCard(item: Objects[random])
            cardOfTheDay.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: Card.cover))
            lbCardName.text = Card.name
            lbDescription.text =  Card.text
        }
        
        self.title = "Home"
        
        // Do any additional setup after loading the view, typically from a nib.
        
        // SessionController.sharedInstance.REST.getCard(name: "alchemist")
        // let data = GWENT_Data()
        // data.deleteCards()
        // data.saveCard(card: Card(_name : "alchemist" , _artwork: "alchemist"))
        // SessionController.sharedInstance.REST.getAllCards(callback: Callback)
        
        // me trae una imagen del document folder
        
        // let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // let image  = documentsUrl.appendingPathComponent("blue-stripes-commando_small.png")
        // debugPrint(image)
        // UIImage(
        // SessionControler.sharedInstance.REST.DownloadImage(url: "https://api.gwentapi.com/media/blue-stripes-commando_small.png", callback: callbackDownload)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // navigationItem.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // este boton se usa?
    @IBAction func btnTestPressed(_ sender: AnyObject)
    {
        // SessionController.sharedInstance.REST.getCard(name: "alchemist" , callback: CallBackCardOfTheDay)
    }
    
    func loadButtons()
    {
        // let button = UIButton(type: .custom)
        // button.frame = CGRect(x: 160.0, y: 100.0, width: 50.0, height: 50.0)
        // button.layer.cornerRadius = 0.5 * button.bounds.size.width
        // button.setImage(UIImage(named:"Monsters.png"), for: .normal)
        // button.addTarget(self, action: #selector(BtnPressed), for: .touchUpInside)
        // view.addSubview(button)
    }
    
    func CallBackCardOfTheDay(json:JSON)
    {
        
    }
    
    //     y este XD
    func BtnPressed()
    {
        print("Working")
    }
}

