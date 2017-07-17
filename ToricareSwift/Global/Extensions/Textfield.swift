//
//  Textfield.swift
//  
//
//  Created by Mèo Béo on 6/30/17.
//
//

import UIKit

extension UITextField{
    func textFieldStyle(placeHolder: String?,
                        fontSize: CGFloat? = TEXTFIELD_FONT_SIZE,
                        textColor: String? = TEXTFIELD_FONT_COLOR,
                        borderWidth: CGFloat? = TEXTFIELD_BORDER_WIDTH,
                        borderColor: String? = TEXTFIELD_BORDER_COLOR,
                        radius: CGFloat? = TEXTFIELD_RADIUS,
                        backgroundColor: String? = TEXTFIELD_BACKGROUND){
        let textField = self
        
        if(placeHolder != nil){
            textField.placeholder = placeHolder!
        }
        if(fontSize != nil){
            textField.font = UIFont.init(name: "HiraginoSans-W3", size: fontSize!)// textField.font?.withSize(fontSize!)
        }
        if(textColor != nil){
            textField.textColor = UIColor.init(hexString: textColor!)
        }
        if(borderWidth != nil){
            textField.layer.borderWidth = borderWidth!
        }
        if(borderColor != nil){
            textField.layer.borderColor = UIColor.init(hexString: borderColor!).cgColor
        }
        if(radius != nil){
            textField.layer.cornerRadius = radius!
            textField.clipsToBounds = true
        }
        if(backgroundColor != nil){
            textField.backgroundColor = UIColor.init(hexString: backgroundColor!)
        }
    }
}
