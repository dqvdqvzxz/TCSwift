//
//  TRCRegisterViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCRegisterViewController: TRCBaseViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblRePassword: UILabel!
    @IBOutlet weak var lblOr: UILabel!
    
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfRePassword: UITextField!
    
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnRegisterWithFB: UIButton!
    
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
        //back button
        self.navigationController?.navigationBar.backItem?.title = kBackButton
        self.navigationController?.navigationBar.topItem?.title = kTitleRegister
        
        //UI of outlet
        lblUsername.labelStyle(title: kLblUsername, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblPassword.labelStyle(title: kLblPassword, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblRePassword.labelStyle(title: kLblRePassword, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblOr.labelStyle(title: kLblOr, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        tfUsername.textFieldStyle(placeHolder: kTfUsernamePH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfPassword.textFieldStyle(placeHolder: kTfPasswordPH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        tfRePassword.textFieldStyle(placeHolder: kTfRePasswordPH, fontSize: TEXTFIELD_FONT_SIZE, textColor: TEXTFIELD_FONT_COLOR, borderWidth: TEXTFIELD_BORDER_WIDTH, borderColor: TEXTFIELD_BORDER_COLOR, radius: TEXTFIELD_RADIUS, backgroundColor: nil)
        
        btnRegister.buttonStyle(title: kTitleRegister, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        btnRegisterWithFB.buttonStyle(title: kBtnRegisterWithFB, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BUTTON_REGISTER_FB)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnRegister(_ sender: Any) {
        let vc = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnRegisterWithFB(_ sender: Any) {
    }
    
}
