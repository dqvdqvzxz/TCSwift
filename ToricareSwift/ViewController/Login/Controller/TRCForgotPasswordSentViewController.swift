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
    @IBOutlet weak var lblInform3: UILabel!
    
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
        
        //UI of outlet
        let informString = Localizable(value: "send_reset_password_mail")
        lblInform1.labelStyle(title: informString)
        lblInform3.labelStyle(title: Localizable(value: "reset_password_done_message"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblInform1.makeLineSpacing()
        lblInform3.makeLineSpacing()
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
