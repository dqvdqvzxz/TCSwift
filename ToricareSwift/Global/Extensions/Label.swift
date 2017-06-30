//
//  Label.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/30/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UILabel{
    func styleLabel(title: String?, fontSize: CGFloat?, textColor: String?){
        let label = self
        if(title != nil){
            label.text = title
        }
        if(fontSize != nil){
            label.font = label.font.withSize(fontSize!)
        }
        if(textColor != nil){
            label.textColor = UIColor.init(hexString: textColor!)
        }
    }
}
