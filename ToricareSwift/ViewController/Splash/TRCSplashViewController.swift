//
//  TRCSplashViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSplashViewController: TRCBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //set root view
        if(UserDefaults.getUD(ACCESS_TOKEN) != nil && UserDefaults.getUD(REFRESH_ACCESS_TOKEN) != nil){
            //check internet
            if Connectivity.isConnectToNetwork() == false{
                //init tabbar controller
                _obj.initTabbarController()

                //set rootview
                UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                }, completion: { completed in
                    // maybe do something here
                })
            }else{
                //refresh token
                self.showHUD()
                //bo qua ko chay success hay error
                TRCTokenRequest().refreshToken(UserDefaults.getUD(ACCESS_TOKEN) as! String, UserDefaults.getUD(REFRESH_ACCESS_TOKEN) as! String, completion: {(data) in
                    let dataResult = data?.object(forKey: DATA) as! NSDictionary

                    // Save access token
                    if (Global().isNotNull(dataResult.object(forKey: ACCESS_TOKEN))) {
                        UserDefaults.saveUD(dataResult.object(forKey: ACCESS_TOKEN), ACCESS_TOKEN)
                    }

                    if (Global().isNotNull(dataResult.object(forKey: REFRESH_ACCESS_TOKEN))) {
                        UserDefaults.saveUD(dataResult.object(forKey: REFRESH_ACCESS_TOKEN), REFRESH_ACCESS_TOKEN)
                    }
                    
                    self.hideHUD()
                    
                    //init tabbar controller
                    _obj.initTabbarController()

                    //set rootview
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                    }, completion: { completed in
                        // maybe do something here
                    })
                }) { (error) in
                    self.hideHUD()
                    let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
                    let navController = UINavigationController(rootViewController: mainVC)
                    UIApplication.shared.keyWindow?.rootViewController = navController
                }
            }
        }else{
            let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
            let navController = UINavigationController(rootViewController: mainVC)
            UIApplication.shared.keyWindow?.rootViewController = navController
        }
    }
}
