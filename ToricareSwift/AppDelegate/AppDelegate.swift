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
        }
        
        //handle schema facebook
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String!, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        
        
        return handled
    }
    
    //MARK: Config UI
    func configUI(){

        //init window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //set color for navigation
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
        UINavigationBar.appearance().tintColor = UIColor.init(hexString: MAIN_COLOR)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: MAIN_COLOR)]
        
        //set color for tabbar
        UITabBar.appearance() .isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.init(hexString: WHITE_COLOR)
        UITabBar.appearance().tintColor = UIColor.init(hexString: WHITE_COLOR)
        
        _obj.tabController.delegate = self
        
        //init root view
        let mainVC = TRCSplashViewController(nibName: "TRCSplashViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: mainVC)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

extension AppDelegate: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        _obj.customizeTabbar(tabBarController.selectedIndex)
    }
}
