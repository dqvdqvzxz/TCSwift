//
//  TRCObject.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

final class Singleton{
    static let shared = Singleton()

    //navigation
    var nc1 = UINavigationController()
    var nc2 = UINavigationController()
    var nc3 = UINavigationController()
    var nc4 = UINavigationController()
    var nc5 = UINavigationController()
    
    //tabbar
    var tabController = UITabBarController()
    
    //dictionary
    var dicFacebookInfo = [String:String]()
    
    var dicPasscode = [String:String]()
    
    var objectAccountInfo = TRCAccountInfo()
    
    var objectGoal = TRCGoal()
    
    var newStep = ""
}

