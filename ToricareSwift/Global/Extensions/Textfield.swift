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
    
    func addLeftImage(_ image: UIImage){
        let textField = self

        textField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        imageView.image = image
        imageView.contentMode = .center
        textField.leftView = imageView
    }
    
    func addRightImage(_ image: UIImage){
        let textField = self
        
        textField.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imageView.image = image
        imageView.contentMode = .center
        textField.rightView = imageView
    }
}
