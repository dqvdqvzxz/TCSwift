//
//  TRCEmailChangeInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCEmailChangeInputViewController: TRCBaseViewController {

    @IBOutlet weak var lblCurrentEmail: UILabel!
    @IBOutlet weak var lblCurrentEmailResult: UILabel!
    @IBOutlet weak var lblNewEmail: UILabel!
    @IBOutlet weak var lblConfirmNewEmail: UILabel!
    @IBOutlet weak var lblInform: UILabel!
    
    @IBOutlet var viewLine: UIView!
    
    @IBOutlet weak var tfNewEmail: UITextField!
    @IBOutlet weak var tfConfirmNewEmail: UITextField!
    
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
        self.navigationItem.title = STRING_SETTING_EMAIL_CHANGE
        
        //UI of outlet
        lblCurrentEmail.labelStyle(title: Localizable(value: "current_email"))
        lblCurrentEmailResult.labelStyle(title: _obj.objectAccountInfo.email, fontSize: LABEL_FONT_SIZE, textColor: MAIN_COLOR)
        lblNewEmail.labelStyle(title: Localizable(value: "new_mail"))
        lblConfirmNewEmail.labelStyle(title: Localizable(value: "new_mail_confirm"))
        lblInform.labelStyle(title: Localizable(value: "inform_change_email"))
        lblInform.labelStyle(title: Localizable(value: "inform_change_email"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblInform.lineBreakMode = .byWordWrapping
        lblInform.numberOfLines = 0
        lblInform.makeLineSpacing()
        
        tfNewEmail.textFieldStyle(placeHolder: "")
        tfConfirmNewEmail.textFieldStyle(placeHolder: "")
        
        btnConfirm.buttonStyle(title: STRING_CHANGE)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnConfirm(_ sender: Any) {
        validate()
    }
    
    //MARK: Validate
    func validate(){
        if (tfNewEmail.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_change_email"))
            return
        }
        if !(tfNewEmail.text?.isEmail)! {
            self.showAlert(Localizable(value: "please_input_correct_email_type"))
            return
        }
        
        
        if (tfConfirmNewEmail.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_change_confirm_email"))
            return
        }
        if (tfConfirmNewEmail.text?.isEmail)! {
            self.showAlert(Localizable(value: "please_input_correct_email_type"))
            return
        }

        
        if (tfNewEmail.text != tfConfirmNewEmail.text) {
            self.showAlert(Localizable(value: "email_change_did_not_match"))
            return
        }
        
        changeEmail()
    }
    
    //MARK: Change email
    func changeEmail(){
        self.showHUD()
        TRCEmailRequest().EmailChange(tfConfirmNewEmail.text!, completion: {(data) in
            self.hideHUD()
            let vc = TRCEmailChangeCompleteViewController(nibName: "TRCEmailChangeCompleteViewController", bundle: nil)
            _obj.nc5.pushViewController(vc, animated: true)
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
    }
}
