//
//  View.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/30/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UIView{
    func viewStyle(borderWidth: CGFloat?, borderColor: String?, radius: CGFloat?, backgroundColor: String?){
        let view = self
        if(borderWidth != nil){
            view.layer.borderWidth = borderWidth!
        }
        if(borderColor != nil){
            view.layer.borderColor = UIColor.init(hexString: borderColor!).cgColor
        }
        if(radius != nil){
            view.layer.cornerRadius = radius!
            view.clipsToBounds = true
        }
        if(backgroundColor != nil){
            view.backgroundColor = UIColor.init(hexString: backgroundColor!)
        }
    }
}
