//
//  TRCAboutAppCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/11/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCAboutAppCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVersion: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblTitle.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblVersion.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
