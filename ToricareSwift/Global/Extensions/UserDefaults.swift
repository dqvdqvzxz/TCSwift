//
//  UserDefaults.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UserDefaults{
    class func saveUD(_ value: Any?, _ forKey: String){
        UserDefaults.standard.setValue(value, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
    
    class func getUD(_ key: String) -> Any? {
        return UserDefaults.standard.value(forKey: key)
    }
    
    class func removeUD(_ key: String){
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}
