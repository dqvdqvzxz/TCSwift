//
//  TRCGlobal.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class Global: NSObject {
    func saveUD(_ object: Any?, _ key: String?) {
        let userDefaults = UserDefaults.standard //returns shared defaults object.
        userDefaults.set(object, forKey: key!)
        userDefaults.synchronize()
    }
    
    func getUD(_ key: String?) -> Any? {
        let userDefaults = UserDefaults.standard //returns shared defaults object.
        if ((userDefaults.value(forKey: key!)) != nil) {
            return userDefaults.value(forKey: key!) as Any?
        }
        
        return nil
    }
    
    func isNotNull(_ aValue: Any?) -> Bool {
        let convertedObject = convertObjectToString(aValue)
        return !convertedObject.isBlank
    }
    
    func convertObjectToString(_ aValue: Any?) -> String {
        if (aValue == nil) {
            return ""
        } else{
            if (aValue is String) {
                return aValue as! String
            } else if (aValue is NSString) {
                return aValue as! String
            } else if (aValue is NSNumber) {
                let _number : NSNumber = aValue as! NSNumber
                return _number.stringValue
            } else {
                return ""
            }
        }
    }
}
