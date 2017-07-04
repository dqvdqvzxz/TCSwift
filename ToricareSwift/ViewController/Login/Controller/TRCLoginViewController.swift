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
        self.navigationItem.title = kTitleLogin

        
        //UI of outlet
        lblUsername.labelStyle(title: kLblUsername, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblPassword.labelStyle(title: kLblPassword, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblForgotPassword.labelStyle(title: kForgotPassword, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FORGOT_PASSWORD_FONT_COLOR)
        lblForgotPassword.attributedText = NSAttributedString(string: kForgotPassword, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue])
        lblOr.labelStyle(title: kLblOr, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        tfUsername.textFieldStyle(placeHolder: kTfUsernamePH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfPassword.textFieldStyle(placeHolder: kTfPasswordPH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        
        btnLogin.buttonStyle(title: kTitleLogin, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        btnLoginWithFB.buttonStyle(title: kBtnRegisterWithFB, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BUTTON_REGISTER_FB)

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
    
    func forgotPassword(sender: UITapGestureRecognizer){
        let vc = TRCForgotPasswordEmailInputViewController(nibName: "TRCForgotPasswordEmailInputViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        let vc = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


