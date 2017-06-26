//
//  Alert.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
}

func Alert(title: String){
    let alert = UIAlertController(title: title, message: "", preferredStyle: .alert)
    let action = UIAlertAction(title: kAlertOk, style: .default, handler: nil)
    alert.addAction(action)
    presentViewController(alert: alert, animated: true, completion: nil)
}

func Alert2(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: kAlertOk, style: .default, handler: nil)
    alert.addAction(action)
    presentViewController(alert: alert, animated: true, completion: nil)
}
