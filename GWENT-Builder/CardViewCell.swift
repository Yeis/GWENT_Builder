//
//  CardViewCell.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/21/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import UIKit

class CardViewCell: UICollectionViewCell {

    @IBOutlet var image: UIImageView!
    @IBOutlet var lbName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbName = UILabel()
    }

}
