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
        
    }
    
    func forgotPassword(sender: UITapGestureRecognizer){
        let vc = TRCForgotPasswordEmailInputViewController(nibName: "TRCForgotPasswordEmailInputViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        TRCLoginAPIController().Login(tfUsername.text!, tfPassword.text!, completion: {(data) in
            UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                
                _obj.tabController.selectedIndex = 0
            }, completion: { completed in
                // maybe do something here
            })
        }) { (error) in
            ELog(error)
        }
    }
}


