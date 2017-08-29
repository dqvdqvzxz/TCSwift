//
//  AppDelegate.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import Alamofire

import FBSDKLoginKit

import GoogleMaps
import GooglePlaces

import Fabric
import Crashlytics

import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UserDefaults.resetCommonValue()
        
        //config UI
        configUI()
        
        //set device id
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.saveUD(deviceID, DEVICE_ID)
        
        //google key
//        GMSPlacesClient.provideAPIKey("AIzaSyB2m6vLyb-OvTw1PvmxZH1de0TVa_d93HQ")
        GMSServices.provideAPIKey("AIzaSyBvfVsig1-BAp25H8SEObaUGfZYFxGMdWY")

        //facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)

        //fabric
        Fabric.with([Crashlytics.self])
        
        //IQKeyboard
        IQKeyboardManager.sharedManager().enable = true
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if(UserDefaults.getUD(PASSCODE) != nil){
            let mainVC = TRCPasscodeLockLoginInputViewController(nibName: "TRCPasscodeLockLoginInputViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
        } 
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        //handle schema website
        if(url.scheme == "tri-care.com"){
            //delete data
            UserDefaults.clearValueWhenLogout()
            _obj.clearObject()
            
            //push to pre login
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
        }else{
            //if url.schema is blank
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
        }
        
        //handle schema facebook
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        
        return handled
    }
    
    

//    //MARK: Config UI
//    func configUI(){
//        
//        //init window
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
//        
//        //set theme style
//        //        UITabBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
//        
//        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
//        
////        UINavigationBar.appearance().tintColor = UIColor.init(hexString: BUTTON_TITLE_COLOR)
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: MAIN_COLOR)]
//        
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(hexString: MAIN_COLOR)], for: .normal)
//        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: MAIN_COLOR], for: .highlighted)
//        
//        
//        //init splash
//        let mainVC = TRCSplashViewController(nibName: "TRCSplashViewController", bundle: nil)
//        let navController = UINavigationController(rootViewController: mainVC)
//        
////        let mainVC = TRCSplashViewController(nibName: "View", bundle: nil)
////        let navController = UINavigationController(rootViewController: mainVC)
//
//        
//        //init root view
//        window?.rootViewController = navController
//        window?.makeKeyAndVisible()
//    }
//    
//    func configTabbar(){
//        //init root view controller
//        let vc1 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
//        let vc2 = TRCTab2ViewController(nibName: "TRCTab2ViewController", bundle: nil)
//        let vc3 = TRCTab3ViewController(nibName: "TRCTab3ViewController", bundle: nil)
//        let vc4 = TRCTab4ViewController(nibName: "TRCTab4ViewController", bundle: nil)
//        let vc5 = TRCMyPageViewController(nibName: "TRCMyPageViewController", bundle: nil)
//        
//        //init root nav controller
//        let nc1 = _obj.nc1
//        let nc2 = _obj.nc2
//        let nc3 = _obj.nc3
//        let nc4 = _obj.nc4
//        let nc5 = _obj.nc5
//        
//        //init tabbar
//        nc1.viewControllers = [vc1]
//        nc2.viewControllers = [vc2]
//        nc3.viewControllers = [vc3]
//        nc4.viewControllers = [vc4]
//        nc5.viewControllers = [vc5]
//        _obj.tabController.viewControllers = [nc1, nc2, nc3, nc4, nc5]
//        
//        
//        //set default tab
//        _obj.tabController.selectedIndex = 0
//        
//        //set item for tabbar item
//        let item1 = _obj.tabController.tabBar.items?[0]
//        let item2 = _obj.tabController.tabBar.items?[1]
//        let item3 = _obj.tabController.tabBar.items?[2]
//        let item4 = _obj.tabController.tabBar.items?[3]
//        let item5 = _obj.tabController.tabBar.items?[4]
//        
//        //set title for tab item
//        item1?.title = STRING_TAB_HOME
//        item2?.title = STRING_TAB_NUTRITION
//        item3?.title = STRING_TAB_EXERCISE
//        item4?.title = STRING_TAB_MEDICINE
//        item5?.title = STRING_TAB_MYPAGE
//        
//        item1?.image = #imageLiteral(resourceName: "home")
//        item1?.selectedImage = #imageLiteral(resourceName: "home_hl")
//        
//        item2?.image = #imageLiteral(resourceName: "nutrition")
//        item2?.selectedImage = #imageLiteral(resourceName: "nutrition_hl")
//        
//        item3?.image = #imageLiteral(resourceName: "run")
//        item3?.selectedImage = #imageLiteral(resourceName: "run_hl")
//        
//        item4?.image = #imageLiteral(resourceName: "pill")
//        item4?.selectedImage = #imageLiteral(resourceName: "pill_hl")
//        
//        item5?.image = #imageLiteral(resourceName: "profile")
//        item5?.selectedImage = #imageLiteral(resourceName: "profile_hl")
//        
//        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: MAIN_COLOR)]
//        let uhnSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: LABEL_FONT_GREY_COLOR)]
//        
//        item1?.setTitleTextAttributes(uhnSelectedItem, for: .normal)
//        item1?.setTitleTextAttributes(selectedItem, for: .selected)
//        
//        item2?.setTitleTextAttributes(uhnSelectedItem, for: .normal)
//        item2?.setTitleTextAttributes(selectedItem, for: .selected)
//        
//        item3?.setTitleTextAttributes(uhnSelectedItem, for: .normal)
//        item3?.setTitleTextAttributes(selectedItem, for: .selected)
//        
//        item4?.setTitleTextAttributes(uhnSelectedItem, for: .normal)
//        item4?.setTitleTextAttributes(selectedItem, for: .selected)
//        
//        item5?.setTitleTextAttributes(uhnSelectedItem, for: .normal)
//        item5?.setTitleTextAttributes(selectedItem, for: .selected)
//    }
    
    
        //MARK: Config UI
        func configUI(){
    
            //init window
            window = UIWindow(frame: UIScreen.main.bounds)
    
    
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
            
            
            //set color for navigation
            UINavigationBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
            UINavigationBar.appearance().tintColor = UIColor.init(hexString: MAIN_COLOR)
            UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: MAIN_COLOR)]
            
            //set color for tabbar
            UITabBar.appearance().isTranslucent = false
            UITabBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
            UITabBar.appearance().tintColor = UIColor.init(hexString: WHITE_COLOR)
            
            //init root view
            let mainVC = TRCSplashViewController(nibName: "TRCSplashViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            
            window?.rootViewController = navController
            window?.makeKeyAndVisible()
        }
    
    
    func configTabbar(){
        //set color background
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: TABBAR_COLOR_1), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //set color for select item
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
        
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(selectedItem, for: .selected)
        
        //set image
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "home")
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "home_hl")
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
    }
}
