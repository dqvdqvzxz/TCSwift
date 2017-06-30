//
//  Label.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/30/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UILabel{
    func styleLabel(title: String, fontSize: CGFloat, textColor: String){
        let label = self
        label.text = title
        label.font = label.font.withSize(fontSize)
        label.textColor = UIColor.init(hexString: textColor)
    }
}
