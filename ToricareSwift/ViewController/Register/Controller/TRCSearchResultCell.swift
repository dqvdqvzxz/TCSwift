//
//  TRCSearchResultCell.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import AlamofireImage

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
    
    func fillData(pharmacyObject: TRCPharmacy) {
        lblName.labelStyle(title: pharmacyObject.name,
                           fontSize: LABEL_FONT_SIZE! + 2,
                           isBold: false,
                           textColor: LABEL_FONT_COLOR)
        
        lblAddress.labelStyle(title: pharmacyObject.address1,
                              fontSize: LABEL_FONT_SIZE,
                              isBold: false,
                              textColor: LABEL_FONT_GREY_COLOR)

        if (pharmacyObject.images.count > 0) {
            guard let url = URL(string: pharmacyObject.images[0].origin) else { return }
            imgPharmacy.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "no_image"))
        } else {
            imgPharmacy.image = #imageLiteral(resourceName: "no_image")
        }
    }
}
