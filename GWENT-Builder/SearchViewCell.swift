//
//  SearchViewCell.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 10/18/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import UIKit
import Foundation
class SearchViewCell: UITableViewCell {
    
 
    @IBOutlet var lbOptionName: UILabel!
    @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
