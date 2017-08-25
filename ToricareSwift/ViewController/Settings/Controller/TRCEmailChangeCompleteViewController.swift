//
//  TRCEmailChangeCompleteViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCEmailChangeCompleteViewController: TRCBaseViewController {

    @IBOutlet weak var lblMailSent1: UILabel!
    @IBOutlet weak var lblMailSent2: UILabel!
    @IBOutlet weak var lblMailSent3: UILabel!
    
    @IBOutlet weak var btnBackToMyPage: UIButton!
    
    //MARL: View controller
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
        lblMailSent1.labelStyle(title: Localizable(value: "mail_sent_message1"))
        lblMailSent2.labelStyle(title: Localizable(value: "mail_sent_message2"))
        lblMailSent3.labelStyle(title: Localizable(value: "mail_sent_message3"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: BACKGROUND_COLOR)
        
        lblMailSent2.lineBreakMode = .byWordWrapping
        lblMailSent2.numberOfLines = 0
        lblMailSent3.lineBreakMode = .byWordWrapping
        lblMailSent3.numberOfLines = 0
        
        lblMailSent2.makeLineSpacing()
        lblMailSent3.makeLineSpacing()
        
        btnBackToMyPage.buttonStyle(title: Localizable(value: "back_to_top"))
    }
    
    //MARK: Button Action
    @IBAction func tapBtnBackToMyPage(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for descView in viewControllers {
            if(descView is TRCSettingViewController){
                _obj.nc5.popToViewController(descView, animated: true)
            }
        }
    }

}
