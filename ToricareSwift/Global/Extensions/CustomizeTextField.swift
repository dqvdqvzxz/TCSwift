//
//  CustomizeTextField.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/16/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import Foundation
import UIKit

class CustomizeTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(select(_:)) {
            return false
        }
        if action == #selector(selectAll(_:)) {
            return false
        }
        if action == #selector(cut(_:)) {
            return false
        }
        if action == #selector(copy(_:)) {
            return false
        }
        if action == #selector(paste(_:)) {
            return false
        }
        if action == #selector(delete(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}
