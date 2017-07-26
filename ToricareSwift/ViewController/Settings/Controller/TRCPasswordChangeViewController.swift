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
        let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        _obj.nc5.pushViewController(vc, animated: true)
    }
}
