//
//  TRCSearchResultCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSearchResultCell: UITableViewCell {

    @IBOutlet weak var imgPharmacy: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData(pharmacyObject: TRCPharmacyObject?) {
        if pharmacyObject != nil {
            imgPharmacy.image = pharmacyObject!.pharmacyImage
            lblName.labelStyle(title: pharmacyObject!.pharmacyName, fontSize: LABEL_FONT_SIZE! + 2, isBold: true, textColor: LABEL_FONT_COLOR)
            lblAddress.labelStyle(title: pharmacyObject!.pharmacyAddress, fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
            lblAddress.text = pharmacyObject!.pharmacyAddress
        }
    }    
}
