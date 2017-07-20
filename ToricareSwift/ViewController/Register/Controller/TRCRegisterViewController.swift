//
//  TRCRegisterViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import FacebookLogin
import FacebookCore
import FBSDKLoginKit

class TRCRegisterViewController: TRCBaseViewController {
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblRePassword: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnRegisterWithFB: UIButton!
    
    @IBOutlet weak var viewLineLeft: UIView!
    @IBOutlet weak var viewLineRight: UIView!
    
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
        self.navigationItem.title = STRING_REGISTER
        
        //UI of outlet
        lblUsername.labelStyle(title: STRING_MAIL_ADDRESS)
        lblPassword.labelStyle(title: STRING_PASSWORD)
        lblRePassword.labelStyle(title: Localizable(value: "password_confirm"))
        lblOr.labelStyle(title: Localizable(value: "or"))
        
        tfUsername.textFieldStyle(placeHolder: "")
        tfPassword.textFieldStyle(placeHolder: "")
        tfRePassword.textFieldStyle(placeHolder: "")
        
        btnRegister.buttonStyle(title: Localizable(value: "register_mail"))
        btnRegisterWithFB.buttonStyle(title: Localizable(value: "register_fb"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_REGISTER_FB_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BUTTON_REGISTER_FB_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnRegister(_ sender: Any) {
        let vc = TRCAccountInfoInputViewController(nibName: "TRCAccountInfoInputViewController", bundle: nil)
        vc.editMode = MODE_REGISTER
        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.viewControllers.remove(at: 1)
    }
    
    @IBAction func tapBtnRegisterWithFB(_ sender: Any) {
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
                if let fbFirstName = FBSDKProfile.current().firstName{
                    _obj.dicFacebookInfo.updateValue(fbFirstName, forKey: FB_FIRSTNAME)
                }
                if let fbMiddleName = FBSDKProfile.current().middleName{
                    _obj.dicFacebookInfo.updateValue(fbMiddleName, forKey: FB_MIDDLENAME)
                }
                if let fbLastName = FBSDKProfile.current().lastName{
                    _obj.dicFacebookInfo.updateValue(fbLastName, forKey: FB_LASTNAME)
                }
                if let fbName = FBSDKProfile.current().name{
                    _obj.dicFacebookInfo.updateValue(fbName, forKey: FB_NAME)
                }
                if let fbUserID = FBSDKProfile.current().userID{
                    _obj.dicFacebookInfo.updateValue(fbUserID, forKey: FB_USERID)
                }
                
                //get email, avatar
                let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"email, picture.type(large)"])
                graphRequest.start(completionHandler: { (connection, result, error) -> Void in
                    if ((error) != nil){
                        ELog("Error: \(String(describing: error))")
                    }else{
                        let data:[String:AnyObject] = result as! [String : AnyObject]
                        
                        let picture = data["picture"]
                        let avatar = picture?.object(forKey: "data")
                        let avatarURL = (avatar as AnyObject).object(forKey: "url")

                        if let fbEmail = data["email"]{
                            _obj.dicFacebookInfo.updateValue(fbEmail as! String, forKey: FB_EMAIL)
                        }
                        if let fbAvatar = avatarURL{
                            _obj.dicFacebookInfo.updateValue(fbAvatar as! String, forKey: FB_AVATAR)
                        }
                        
                        
                        
                    }
                })
            }
        }
        
    }
    
}
