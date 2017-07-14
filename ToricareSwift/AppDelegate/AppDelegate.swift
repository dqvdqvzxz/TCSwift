//
//  AppDelegate.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import Alamofire
import FacebookCore
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        configUI()
        
        //set device id
        let deviceID = UIDevice.current.identifierForVendor!.uuidString
        UserDefaults.kSetValue(deviceID, DEVICE_ID)

        
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        AppEventsLogger.activate(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url as URL!, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    //MARK: Config UI
    func configUI(){
        //init window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //init root view controller
        let vc1 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let vc2 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let vc3 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let vc4 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
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
        
        
        //set default tab
        _obj.tabController.selectedIndex = 0
        
        //set item for tabbar item
        let item1 = _obj.tabController.tabBar.items?[0]
        let item2 = _obj.tabController.tabBar.items?[1]
        let item3 = _obj.tabController.tabBar.items?[2]
        let item4 = _obj.tabController.tabBar.items?[3]
        let item5 = _obj.tabController.tabBar.items?[4]
        
        //set title for tab item
        item1?.title = STRING_TAB_HOME
        item2?.title = STRING_TAB_NUTRITION
        item3?.title = STRING_TAB_EXERCISE
        item4?.title = STRING_TAB_MEDICINE
        item5?.title = STRING_TAB_MYPAGE
        
//        //set icon for tab item
//        item1?.image = UIImage(named: "")
//        item2?.image = UIImage(named: "")
//        item3?.image = UIImage(named: "")
//        item4?.image = UIImage(named: "")
//        item5?.image = UIImage(named: "")
//        
//        //set selected icon for tab item
//        item1?.selectedImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//        item2?.selectedImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//        item3?.selectedImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//        item4?.selectedImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
//        item5?.selectedImage = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        
        //set theme style
        let currentTheme = UserDefaults.kGetValue(THEME_COLOR)
        if(currentTheme != nil){
            UINavigationBar.appearance().barTintColor = UIColor.init(hexString: currentTheme as! String)
            UITabBar.appearance().barTintColor = UIColor.init(hexString: currentTheme as! String)
        }else{
            UINavigationBar.appearance().barTintColor = UIColor.init(hexString: MAIN_COLOR)
            UITabBar.appearance().barTintColor = UIColor.init(hexString: MAIN_COLOR)
        }

        UINavigationBar.appearance().tintColor = UIColor.init(hexString: BUTTON_TITLE_COLOR)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: BUTTON_TITLE_COLOR)]
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(hexString: BUTTON_TITLE_COLOR)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: BUTTON_TITLE_COLOR], for: .highlighted)
        
        
        //set root view
        if(UserDefaults.kGetValue(FB_TOKEN) != nil){
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
//            window?.rootViewController = _obj.tabController
        }else{
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
        }
        window?.makeKeyAndVisible()
    }
}
