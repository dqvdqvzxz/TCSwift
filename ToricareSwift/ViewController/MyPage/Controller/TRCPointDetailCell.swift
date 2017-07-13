//
//  TRCPointDetailCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPointDetailCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var lblPointUnit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblTitle.labelStyle(title: nil, fontSize: LABEL_FONT_CELL_TITLE_SIZE, textColor: LABEL_FONT_COLOR)
        lblSubTitle.labelStyle(title: nil, fontSize: LABEL_FONT_CELL_SUBTITLE_SIZE, textColor: LABEL_FONT_COLOR)
        lblPoint.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblPointUnit.labelStyle(title: kPointUnit, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
