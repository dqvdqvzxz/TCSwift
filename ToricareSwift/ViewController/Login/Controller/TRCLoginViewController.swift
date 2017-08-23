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
    
    var accountInfo: TRCAccountInfo!
    
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
    
    func onProfileUpdated(){
        //get facebook id
        let fbUserID = FBSDKProfile.current().userID
        
        //process login
        TRCLoginRequest().loginFB(fbUserID!, UserDefaults.getUD(FB_TOKEN) as! String, completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            
            //get account info
            TRCAccountInfoRequest().accountInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                self.hideHUD()
                
                do {
                    self.accountInfo = try parseDict(dataResult as! JSONObject) as TRCAccountInfo
                    _obj.objectAccountInfo = self.accountInfo
                } catch {
                    print("JSONParsin Error: \(error)")
                }
                
                //check info
                if(_obj.objectAccountInfo.firstName == "" || _obj.objectAccountInfo.lastName == ""){
                    //push to AccountInfoInputView
                    let mainVC = TRCAccountInfoInputViewController(nibName: "TRCAccountInfoInputViewController", bundle: nil)
                    _obj.mode = MODE_REGISTER
                    let navController = UINavigationController(rootViewController: mainVC)
                    
                    // Back to Home
                    self.navigationController?.popToRootViewController(animated: false)
                    _obj.tabController.selectedIndex = 0
                    
                    UIApplication.shared.keyWindow?.rootViewController = navController
                }else{
                    // Save access token
                    if (Global().isNotNull(dataResult.object(forKey: ACCESS_TOKEN))) {
                        UserDefaults.saveUD(dataResult.object(forKey: ACCESS_TOKEN), ACCESS_TOKEN)
                    }
                    
                    if (Global().isNotNull(dataResult.object(forKey: REFRESH_ACCESS_TOKEN))) {
                        UserDefaults.saveUD(dataResult.object(forKey: REFRESH_ACCESS_TOKEN), REFRESH_ACCESS_TOKEN)
                    }
                    
                    //init tabbar
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.configTabbar()
                    
                    //push to home view
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                        _obj.tabController.selectedIndex = 0
                    }, completion: { completed in
                        // maybe do something here
                    })
                }
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }) { (error) in
            self.showAlert(error)
            ELog(error)
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for descView in viewControllers {
                if(descView is TRCPreLoginViewController){
                    self.navigationController?.popToViewController(descView, animated: true)
                }
            }
        }
    }
    
    //MARK: Function
    func loginFB(){
        let loginManager = LoginManager()
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        NotificationCenter.default.addObserver(self, selector: #selector(onProfileUpdated), name: NSNotification.Name.FBSDKProfileDidChange, object: nil)
        
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
                UserDefaults.saveUD(token, FB_TOKEN)
                
                return
            }
        }
    }
    
    func forgotPassword(sender: UITapGestureRecognizer){
        let vc = TRCForgotPasswordEmailInputViewController(nibName: "TRCForgotPasswordEmailInputViewController", bundle: nil)
        backButton()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        validate()
    }
    
    func validate() {
        if (tfUsername.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_mail"))
            return
        }
        
        if !((tfUsername.text?.isEmail)!) {
            self.showAlert(Localizable(value: "please_input_validate_mail"))
            return
        }
        
        if (tfPassword.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_password"))
            return
        }

        doLogin()
    }
    
    func doLogin() {
        // *Message*
        // Login fail then show : self.showAlert(Localizable(value: "please_login_again"))
        
        self.showHUD()
        TRCLoginRequest().login(tfUsername.text!.trim(), tfPassword.text!, completion: {(data) in
            let dataLoginResult = data?.object(forKey: DATA) as! NSDictionary
            
            // Save access token
            if (Global().isNotNull(dataLoginResult.object(forKey: ACCESS_TOKEN))) {
                UserDefaults.saveUD(dataLoginResult.object(forKey: ACCESS_TOKEN), ACCESS_TOKEN)
            }
            
            //get account info
            TRCAccountInfoRequest().accountInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary

                self.hideHUD()
                do {
                    self.accountInfo = try parseDict(dataResult as! JSONObject) as TRCAccountInfo
                    _obj.objectAccountInfo = self.accountInfo
                } catch {
                    print("JSONParsin Error: \(error)")
                }
                
                //check info
                if(_obj.objectAccountInfo.firstName == "" || _obj.objectAccountInfo.lastName == ""){
                    //push to AccountInfoInputView
                    let mainVC = TRCAccountInfoInputViewController(nibName: "TRCAccountInfoInputViewController", bundle: nil)
                    _obj.mode = MODE_REGISTER
                    let navController = UINavigationController(rootViewController: mainVC)
                    
                    // Back to Home
                    self.navigationController?.popToRootViewController(animated: false)
                    _obj.tabController.selectedIndex = 0
                    
                    UIApplication.shared.keyWindow?.rootViewController = navController
                }else{
                    //save refresh token
                    if (Global().isNotNull(dataLoginResult.object(forKey: REFRESH_ACCESS_TOKEN))) {
                        UserDefaults.saveUD(dataLoginResult.object(forKey: REFRESH_ACCESS_TOKEN), REFRESH_ACCESS_TOKEN)
                    }
                    
                    //init tabbar
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.configTabbar()
                    
                    //push to home view
                    UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                        UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                        _obj.tabController.selectedIndex = 0
                    }, completion: { completed in
                        // maybe do something here
                    })
                }
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
    }
}


