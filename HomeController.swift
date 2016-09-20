//
//  HomeController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit


class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //SessionController.sharedInstance.REST.getCard(name: "alchemist")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTestPressed(_ sender: AnyObject)
    {
         SessionController.sharedInstance.REST.getCard(name: "alchemist")
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
    

    func BtnPressed()
    {
       print("Working")
    }
}

