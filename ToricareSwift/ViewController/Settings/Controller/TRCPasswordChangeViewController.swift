//
//  TRCPasswordChangeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasswordChangeViewController: TRCBaseViewController {

    @IBOutlet weak var lblCurrentPassword: UILabel!
    @IBOutlet weak var lblNewPassword: UILabel!
    @IBOutlet weak var lblConfirmNewPassword: UILabel!
    
    @IBOutlet weak var tfCurrentPassword: UITextField!
    @IBOutlet weak var tfNewPassword: UITextField!
    @IBOutlet weak var tfConfirmNewPassword: UITextField!
    
    @IBOutlet weak var btnConfirm: UIButton!
    
    //MARK: View controller
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
        self.navigationItem.title = STRING_SETTING_PASSWORD_CHANGE
        
        //UI of outlet
        lblCurrentPassword.labelStyle(title: Localizable(value: "current_password"))
        lblNewPassword.labelStyle(title: Localizable(value: "new_password"))
        lblConfirmNewPassword.labelStyle(title: Localizable(value: "new_password_confirm"))
        
        tfCurrentPassword.textFieldStyle(placeHolder: "")
        tfNewPassword.textFieldStyle(placeHolder: "")
        tfConfirmNewPassword.textFieldStyle(placeHolder: "")
        
        btnConfirm.buttonStyle(title: STRING_CHANGE)
    }
    
    //MARK: Action
    func validate(){
        if (tfNewPassword.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_new_password"))
            return
        }
        
        if (tfConfirmNewPassword.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_new_password_confirm"))
            return
        }
        
        if (tfNewPassword.text != tfConfirmNewPassword.text) {
            self.showAlert(Localizable(value: "password_did_not_match"))
            return
        }
        
        doChangePassword()
    }
    
    func doChangePassword(){
        self.showHUD()
        TRCPasswordRequest().passwordChange(tfCurrentPassword.text!, tfConfirmNewPassword.text!, completion: {(data) in
            self.hideHUD()
            
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            
            // Save access token
            if (Global().isNotNull(dataResult.object(forKey: ACCESS_TOKEN))) {
                UserDefaults.saveUD(dataResult.object(forKey: ACCESS_TOKEN), ACCESS_TOKEN)
            }
            
            if (Global().isNotNull(dataResult.object(forKey: REFRESH_ACCESS_TOKEN))) {
                UserDefaults.saveUD(dataResult.object(forKey: REFRESH_ACCESS_TOKEN), REFRESH_ACCESS_TOKEN)
            }
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for descView in viewControllers {
                if(descView is TRCSettingViewController){
                    _obj.nc5.popToViewController(descView, animated: true)
                }
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnConfirm(_ sender: Any) {
        validate()
    }
}
