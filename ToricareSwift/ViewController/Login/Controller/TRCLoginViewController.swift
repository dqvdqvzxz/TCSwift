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
    
    @IBOutlet weak var viewLineLeft: UIView!
    @IBOutlet weak var viewLineRight: UIView!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblForgotPassword: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnLoginWithFB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_LOGIN

        
        //UI of outlet
        lblUsername.labelStyle(title: STRING_MAIL_ADDRESS)
        lblPassword.labelStyle(title: STRING_PASSWORD)
        lblForgotPassword.labelStyle(title: Localizable(value: "forgot_password_title"), fontSize: LABEL_FONT_SIZE, textColor: LABEL_FORGOT_PASSWORD_FONT_COLOR)
        lblForgotPassword.attributedText = NSAttributedString(string: Localizable(value: "forgot_password_title"), attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        lblOr.labelStyle(title: Localizable(value: "or"))
        
        tfUsername.textFieldStyle(placeHolder: "")
        tfPassword.textFieldStyle(placeHolder: "")
        
        btnLogin.buttonStyle(title: STRING_DO_LOGIN)
        btnLoginWithFB.buttonStyle(title: Localizable(value: "login_fb"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_REGISTER_FB_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BUTTON_REGISTER_FB_COLOR)


        //add target action
        btnLoginWithFB.addTarget(self, action: #selector(loginFB), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgotPassword))
        lblForgotPassword.isUserInteractionEnabled = true
        lblForgotPassword.addGestureRecognizer(tap)
    }
    
    //MARK: Function
    func loginFB(){
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                ELog(error as! String)
            case .cancelled:
                DLog("User cancelled login.")
            case .success: //let grantedPermissions, let declinedPermissions, let accessToken
                //get token
                let token = FBSDKAccessToken.current().tokenString
                DLog("Access Token: \(String(describing: token!))")
                
                //save facebook token to UserDefaults
                UserDefaults.kSetValue(token, FB_TOKEN)
                
                //upload token into server
                
                //get profile
                let fbFirstName = FBSDKProfile.current().firstName
                let fbMiddleName = FBSDKProfile.current().middleName
                let fbLastName = FBSDKProfile.current().lastName
                let fbName = FBSDKProfile.current().name
                let fbUserID = FBSDKProfile.current().userID
                
                _obj.dicFacebookInfo.updateValue(fbFirstName!, forKey: FB_FIRSTNAME)
                _obj.dicFacebookInfo.updateValue(fbMiddleName!, forKey: FB_MIDDLENAME)
                _obj.dicFacebookInfo.updateValue(fbLastName!, forKey: FB_LASTNAME)
                _obj.dicFacebookInfo.updateValue(fbName!, forKey: FB_NAME)
                _obj.dicFacebookInfo.updateValue(fbUserID!, forKey: FB_USERID)
                
                print(_obj.dicFacebookInfo)
                
                let a = _obj.dicFacebookInfo[FB_USERID]
                print(a)
                
                
                //process after login
                UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                }, completion: { completed in
                    // maybe do something here
                })
            }
        }
    }
    
    func forgotPassword(sender: UITapGestureRecognizer){
        let vc = TRCForgotPasswordEmailInputViewController(nibName: "TRCForgotPasswordEmailInputViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
        }, completion: { completed in
            // maybe do something here
        })
    }
}


