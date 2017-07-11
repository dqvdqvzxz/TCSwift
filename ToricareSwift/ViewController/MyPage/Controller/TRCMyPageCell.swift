//
//  TRCMyPageCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/11/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPageCell: UICollectionViewCell {

    @IBOutlet weak var viewImg: UIView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewImg.backgroundColor = UIColor.init(hexString: MAIN_COLOR)
        viewImg.makeCircle()
        
        imgIcon.backgroundColor = UIColor.init(hexString: BUTTON_TITLE_COLOR)
    }

}
