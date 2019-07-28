//
//  movieTableViewCell.swift
//  flimApp
//
//  Created by Mac on 28/07/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class movieTableViewCell: UITableViewCell {

    @IBOutlet weak var VCContainer: UIView!
    @IBOutlet weak var LBtitle: UILabel!
    
    @IBOutlet weak var LBRatting: UILabel!
    @IBOutlet weak var LBYear: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
