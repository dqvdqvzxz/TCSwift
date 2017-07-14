//
//  TRCForgotPasswordEmailInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCForgotPasswordEmailInputViewController: TRCBaseViewController {
    
    @IBOutlet weak var lblPolicy: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var btnSendEmail: UIButton!
    
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
        self.navigationItem.title = Localizable(value: "reset_password")
        
        //UI of outlet
        lblPolicy.labelStyle(title: Localizable(value: "reset_password_input"), fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblEmail.labelStyle(title: STRING_MAIL_ADDRESS, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        tfEmail.textFieldStyle(placeHolder: "", fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        
        btnSendEmail.buttonStyle(title: STRING_SEND, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnSendEmail(_ sender: Any) {
        let vc = TRCForgotPasswordSentViewController(nibName: "TRCForgotPasswordSentViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
