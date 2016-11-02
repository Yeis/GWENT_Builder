//
//  CardViewCell.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/21/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import UIKit

public class CardViewCell: UICollectionViewCell {

    @IBOutlet var image: UIImageView!
    @IBOutlet var lbName: UILabel!
    
    //variable 
    public var Id:Int!
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  
    }

}
