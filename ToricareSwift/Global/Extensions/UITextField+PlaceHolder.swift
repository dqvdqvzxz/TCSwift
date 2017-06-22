//
//  UITextField+PlaceHolder.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import class UIKit.UITextField

public extension UITextField {
    /**
     Replaces `placeholder` of the textfield with a localized string.
     The locale to be used is derived from the current app environment. If the locale or `key` are not
     recognized, then the textfield's `placeholder` is left unchanged.
     */
    public var localizedPlaceholderKey: String {
        set (key) {
//            self.placeholder = localizedString(key: key, defaultValue: self.placeholder ?? "")
        }
        get {
            return ""
        }
    }
}
