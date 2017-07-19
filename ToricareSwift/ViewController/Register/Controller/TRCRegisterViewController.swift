//
//  TRCRegisterViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

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
        btnRegisterWithFB.buttonStyle(title: Localizable(value: "register_fb"))
    }
    
    //MARK: Button Action
    @IBAction func tapBtnRegister(_ sender: Any) {
        let vc = TRCAccountInfoInputViewController(nibName: "TRCAccountInfoInputViewController", bundle: nil)
        vc.editMode = MODE_REGISTER
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnRegisterWithFB(_ sender: Any) {
    }
    
}
