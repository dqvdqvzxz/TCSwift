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

        print(btnLoginWithFB.frame)
        btnLoginWithFB.layer.backgroundColor = UIColor.blue.cgColor
        btnLoginWithFB.setTitleColor(UIColor.white, for: UIControlState.normal)
        
//        let loginBtn = LoginButton(readPermissions: [.publicProfile])
//        btnLoginWithFB.addSubview(LoginButton)
        
        btnLoginWithFB.addTarget(self, action: #selector(loginFB), for: .touchUpInside)
    }
    
    func loginFB(){
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        }
    }

    @IBAction func tapBtnLoginWithFB(_ sender: Any) {
       
    }
    
}


