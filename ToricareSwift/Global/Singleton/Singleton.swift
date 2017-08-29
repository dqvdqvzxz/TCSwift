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

    var objectGoal: TRCGoal!
    
    var newStep = ""
    
    var objectAccountInfo: TRCAccountInfo!
    
    var objectSummary: TRCSummary!
    
    var mode =  String()
    
    func clearObject(){
        objectGoal = nil
        objectSummary = nil
        objectAccountInfo = nil
        
        dicPasscode.removeAll()
        dicFacebookInfo.removeAll()
    }
    
    func initTabbarController(){
        //init tabbar
        let vc1 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let vc2 = TRCTab2ViewController(nibName: "TRCTab2ViewController", bundle: nil)
        let vc3 = TRCTab3ViewController(nibName: "TRCTab3ViewController", bundle: nil)
        let vc4 = TRCTab4ViewController(nibName: "TRCTab4ViewController", bundle: nil)
        let vc5 = TRCMyPageViewController(nibName: "TRCMyPageViewController", bundle: nil)
        
        //init root nav controller
        let nc1 = _obj.nc1
        let nc2 = _obj.nc2
        let nc3 = _obj.nc3
        let nc4 = _obj.nc4
        let nc5 = _obj.nc5
        
        //init tabbar
        nc1.viewControllers = [vc1]
        nc2.viewControllers = [vc2]
        nc3.viewControllers = [vc3]
        nc4.viewControllers = [vc4]
        nc5.viewControllers = [vc5]
        _obj.tabController.viewControllers = [nc1, nc2, nc3, nc4, nc5]
        
        //set title for tab item
        _obj.tabController.tabBar.items?[0].title = STRING_TAB_HOME
        _obj.tabController.tabBar.items?[1].title = STRING_TAB_NUTRITION
        _obj.tabController.tabBar.items?[2].title = STRING_TAB_EXERCISE
        _obj.tabController.tabBar.items?[3].title = STRING_TAB_MEDICINE
        _obj.tabController.tabBar.items?[4].title = STRING_TAB_MYPAGE
        
        //set default tab
        _obj.tabController.selectedIndex = 0
    }
}

