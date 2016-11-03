
//
//  CardViewer.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/27/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import gwentBusiness
class CardViewer:UIViewController
{
    // Outlets
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var lbRarity: UILabel!
    @IBOutlet var lbText: UILabel!
    @IBOutlet var lbType: UILabel!
    @IBOutlet var lbFaction: UILabel!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var tableview: UITableView!

    // Variables
    var card:Card = Card()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        // navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(.PopRegresar))
        
        // initialize setup
        image.image = UIImage(contentsOfFile: SessionController.sharedInstance.GetImagePath(name: card.cover))
        
        lbName.text = card.name
        lbType.text = "Type: " + card.type
        lbText.text = card.text
        lbRarity.text = card.rarity
        lbFaction.text = "Faction: " + card.faction
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   

}
