//
//  TRCNotificationTableViewCell.swift
//  ToricareSwift
//
//  Created by tuan on 8/24/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblMainTitle.labelStyle(title: "")
        lblSubTitle.labelStyle(title: "", fontSize: LABEL_FONT_SIZE! - 2, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
