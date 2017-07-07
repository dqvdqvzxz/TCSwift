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
        let nc1 = UINavigationController()
        let nc2 = UINavigationController()
        let nc3 = UINavigationController()
        let nc4 = UINavigationController()
        let nc5 = UINavigationController()
        
        //init tabbar
        nc1.viewControllers = [vc1]
        nc2.viewControllers = [vc2]
        nc3.viewControllers = [vc3]
        nc4.viewControllers = [vc4]
        nc5.viewControllers = [vc5]
        let tabController = UITabBarController()
        tabController.viewControllers = [nc1, nc2, nc3, nc4, nc5]
        
        //set default tab
        tabController.selectedIndex = 0
        
        //set item for tabbar item
        let item1 = tabController.tabBar.items?[0]
        let item2 = tabController.tabBar.items?[1]
        let item3 = tabController.tabBar.items?[2]
        let item4 = tabController.tabBar.items?[3]
        let item5 = tabController.tabBar.items?[4]
        
        //set title for tab item
        item1?.title = kTab1
        item2?.title = kTab2
        item3?.title = kTab3
        item4?.title = kTab4
        item5?.title = kTab5
        
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
        
        //set style
        let currentTheme = UserDefaults.kGetValue(THEME_COLOR) as! String
        if(currentTheme != ""){
            UINavigationBar.appearance().barTintColor = UIColor.init(hexString: currentTheme)
            UITabBar.appearance().barTintColor = UIColor.init(hexString: currentTheme)
            
        }else{
            UINavigationBar.appearance().barTintColor = UIColor.init(hexString: MAIN_COLOR)
            UITabBar.appearance().barTintColor = UIColor.init(hexString: MAIN_COLOR)
        }
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.init(hexString: BUTTON_TITLE_COLOR)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: BUTTON_TITLE_COLOR], for: .highlighted)
        
        
        //set root view
        if(UserDefaults.kGetValue(FB_TOKEN) != nil){
            window?.rootViewController = tabController
        }else{
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            window?.rootViewController = navController
        }
        window?.makeKeyAndVisible()
    }
}

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
