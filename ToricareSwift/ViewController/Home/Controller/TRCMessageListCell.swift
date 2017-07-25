//
//  TRCMessageListCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/24/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMessageListCell: UITableViewCell {

    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
