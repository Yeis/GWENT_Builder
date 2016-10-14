//
//  NewCardViewer.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/30/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import gwentBusiness
public class NewCardViewer:UIViewController
{
    //outlets
    @IBOutlet var image: UIImageView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var lbName: UILabel!
    @IBOutlet var lbText: UILabel!
    @IBOutlet var lbType: UILabel!
    @IBOutlet var lbFaction: UILabel!
    
    @IBOutlet var lbLane: UILabel!
    @IBOutlet var lbRarity: UILabel!
    //variables
    var card:Card!
    
    public override func viewDidLoad() {
        //navigationbar setup 
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewCardViewer.Popview))

        
        
        //initial Setup
        image.image = UIImage(contentsOfFile: SessionController.sharedInstance.GetImagePath(name: card.cover))
        lbName.text = card.name
        lbRarity.text = "Rarity: " + card.rarity
        lbLane.text = "Lane: "
        if card.rows.count == 0
        {
            //es un event 
            lbLane.text = "Lane: Event" 
        }
        for row in card.rows
        {
            lbLane.text = lbLane.text! + " | " + row
        }
        lbText.text = card.text
        lbFaction.text = "Faction: " + card.faction
        lbType.text = "Type: " + card.type
        
        //Setup for alternative images 
        if  card.artwork.count == 1 || card.artwork.count == 0
        {
            segmentedControl.isUserInteractionEnabled = false
            
        }
        else
        {
            segmentedControl.removeAllSegments()
            for i in 0...card.artwork.count
            {
                if i == 0
                {
                    segmentedControl.insertSegment(withTitle: "normal", at: i, animated: true)
                }
                else
                {
                    segmentedControl.insertSegment(withTitle: "alt " + String(i) , at: i, animated: true )
                }
                
            }
        }
        
    }
    
    public override func didReceiveMemoryWarning() {
        debugPrint("We are short on memory")
    }
    func Popview(){
        navigationController!.popViewController(animated: true)
    }
   
    
    
}
