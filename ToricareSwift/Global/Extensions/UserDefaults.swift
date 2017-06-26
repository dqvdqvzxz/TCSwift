//
//  UserDefaults.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

extension UserDefaults{
    //MARK: Login state
    class func saveLoginState(_ value: String?){
        UserDefaults.standard.setValue(value, forKey: FB_TOKEN)
        UserDefaults.standard.synchronize()
    }
    
    class func isLogged() -> Any? {
        return UserDefaults.standard.value(forKey: FB_TOKEN)
    }
}
