//
//  TRCForgotPasswordSentViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCForgotPasswordSentViewController: TRCBaseViewController {

    
    @IBOutlet weak var lblInform1: UILabel!
    @IBOutlet weak var lblInform2: UILabel!
    
    @IBOutlet weak var btnBackToHome: UIButton!
    
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
        self.navigationItem.hidesBackButton = true
        
        //UI of outlet
        lblInform1.labelStyle(title: Localizable(value: "send_reset_password_mail"))
        lblInform2.labelStyle(title: Localizable(value: "please_check_mail"))
        
        btnBackToHome.buttonStyle(title: Localizable(value: "back_to_top"))
    }
    
    //MARK: Button Action
    @IBAction func tapBtnBackToHome(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for descView in viewControllers {
            if(descView is TRCPreLoginViewController){
                self.navigationController!.popToViewController(descView, animated: true)
            }
        }
    }
}
