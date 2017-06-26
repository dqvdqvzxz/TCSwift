//
//  TRCObject.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

var strTest: String?
var userDefaults: UserDefaults?

class TRCObject: NSObject {
    class var sharedInstance: TRCObject{
        struct Static{
            static let instance: TRCObject = TRCObject()
        }
        return Static.instance
    }
    
    override init() {
        super.init()
        strTest = String()
        userDefaults = UserDefaults.standard
    }
}
