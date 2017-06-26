//
//  TRCLoginViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class TRCLoginViewController: TRCBaseViewController {

    @IBOutlet weak var btnLoginWithFB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        TRCLoginAPIController().Login("", "", completion: {
            DLog("1")

        }) { (String) in
            DLog("2")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = kTitleLogin

        btnLoginWithFB.layer.backgroundColor = UIColor.blue.cgColor
        btnLoginWithFB.setTitleColor(UIColor.white, for: UIControlState.normal)
        
//        let loginBtn = LoginButton(readPermissions: [.publicProfile])
//        btnLoginWithFB.addSubview(LoginButton)
        
        btnLoginWithFB.addTarget(self, action: #selector(loginFB), for: .touchUpInside)
    }
    
    func loginFB(){
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                ELog(error as! String)
            case .cancelled:
                DLog("User cancelled login.")
            case .success: //let grantedPermissions, let declinedPermissions, let accessToken
                let token = FBSDKAccessToken.current().tokenString
                DLog("Access Token: \(String(describing: token!))")
                
                //save facebook token to UserDefaults
                UserDefaults.kSetValue(token, FB_TOKEN)
                
                //upload token into server
                
                
                //process after login
                let vc = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
}


