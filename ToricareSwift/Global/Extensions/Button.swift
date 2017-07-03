//
//  Border.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/29/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UIButton{
    func buttonStyle(title: String?, fontSize: CGFloat?,titleColor: String?, borderWidth: CGFloat?, borderColor: String?, radius: CGFloat?, backgroundColor: String?){
        let button = self
        if(title != nil){
            button.setTitle(title, for: UIControlState.normal)
        }
        if(fontSize != nil){
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: fontSize!)
        }
        if(titleColor != nil){
            button.setTitleColor(UIColor.init(hexString: titleColor!), for: UIControlState.normal)
        }
        if(borderWidth != nil){
            button.layer.borderWidth = borderWidth!
        }
        if(borderColor != nil){
            button.layer.borderColor = UIColor.init(hexString: borderColor!).cgColor
        }
        if(radius != nil){
            button.layer.cornerRadius = radius!
            button.clipsToBounds = true
        }
        if(backgroundColor != nil){
            button.backgroundColor = UIColor.init(hexString: backgroundColor!)}
    }
}
