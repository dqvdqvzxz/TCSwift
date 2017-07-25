//
//  TRCLinkedServiceCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/6/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

protocol TRCLinkedServiceCellDelegate: class{
    
}

class TRCLinkedServiceCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var switchCell: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblTitle.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblTime.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
