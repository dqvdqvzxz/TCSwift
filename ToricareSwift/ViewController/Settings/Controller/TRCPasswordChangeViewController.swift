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
    
    //MARK: Button Action
    @IBAction func tapBtnConfirm(_ sender: Any) {
        self.showHUD()
        TRCPasswordRequest().passwordChange(tfCurrentPassword.text!, tfConfirmNewPassword.text!, completion: {(data) in
            self.hideHUD()
            
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
}
