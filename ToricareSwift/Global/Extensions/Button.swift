//
//  Border.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/29/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UIButton{
    func styleButton(title: String, fontSize: CGFloat,titleColor: String, borderWidth: CGFloat, borderColor: String, radius: CGFloat, backgroundColor: String){
        let button = self
        button.setTitle(title, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize)
        button.setTitleColor(UIColor.init(hexString: titleColor), for: UIControlState.normal)
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = UIColor.init(hexString: borderColor).cgColor
        button.layer.cornerRadius = radius
        button.clipsToBounds = true
        button.backgroundColor = UIColor.init(hexString: backgroundColor)
    }
}
