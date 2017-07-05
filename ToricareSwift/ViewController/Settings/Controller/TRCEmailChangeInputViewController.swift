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
        self.navigationItem.title = kChangeEmail
        
        //UI of outlet
        lblCurrentEmail.labelStyle(title: kCurrentEmail, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblCurrentEmailResult.labelStyle(title: "test@tricare.com", fontSize: LABEL_FONT_SIZE, textColor: MAIN_COLOR)
        lblNewEmail.labelStyle(title: kNewEmail, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblConfirmNewEmail.labelStyle(title: kConfirmNewEmail, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        tfNewEmail.textFieldStyle(placeHolder: kNewEmailPH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfConfirmNewEmail.textFieldStyle(placeHolder: kConfirmNewEmailPH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        
        btnConfirm.buttonStyle(title: kConfirm, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnConfirm(_ sender: Any) {
    }
}
