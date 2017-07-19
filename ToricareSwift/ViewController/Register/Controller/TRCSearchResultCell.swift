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
            lblName.text = pharmacyObject!.pharmacyName
            lblAddress.text = pharmacyObject!.pharmacyAddress
        }
    }    
}
