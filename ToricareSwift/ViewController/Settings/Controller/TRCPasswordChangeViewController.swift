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
        lblCurrentPassword.labelStyle(title: Localizable(value: "current_password"), fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblNewPassword.labelStyle(title: Localizable(value: "new_password"), fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblConfirmNewPassword.labelStyle(title: Localizable(value: "new_password_confirm"), fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        tfCurrentPassword.textFieldStyle(placeHolder: "", fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfNewPassword.textFieldStyle(placeHolder: "", fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfConfirmNewPassword.textFieldStyle(placeHolder: "", fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        
        btnConfirm.buttonStyle(title: STRING_CHANGE, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnConfirm(_ sender: Any) {
        let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
