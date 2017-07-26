//
//  Label.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/30/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UILabel{
    func labelStyle(title: String? = "",
                    fontSize: CGFloat? = LABEL_FONT_SIZE,
                    isBold: Bool = false,
                    textColor: String? = LABEL_FONT_COLOR){
        let label = self
        if(title != nil){
            label.text = title
        }
        if(fontSize != nil){
            label.font = UIFont.init(name: isBold ? "HiraginoSans-W6" : "HiraginoSans-W3", size: fontSize!)//label.font.withSize(fontSize!)
        }
        if(textColor != nil){
            label.textColor = UIColor.init(hexString: textColor!)
        }
    }
}
