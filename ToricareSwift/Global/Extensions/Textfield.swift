//
//  Textfield.swift
//  
//
//  Created by Mèo Béo on 6/30/17.
//
//

import UIKit

extension UITextField{
    func textFieldStyle(placeHolder: String, fontSize: CGFloat, textColor: String, borderWidth: CGFloat, borderColor: String, radius: CGFloat, backgroundColor: String){
        let textField = self
        textField.placeholder = placeHolder
        textField.font = textField.font?.withSize(fontSize)
        textField.textColor = UIColor.init(hexString: textColor)
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = UIColor.init(hexString: borderColor).cgColor
        textField.layer.cornerRadius = radius
        textField.clipsToBounds = true
        textField.backgroundColor = UIColor.init(hexString: backgroundColor)
    }
}
