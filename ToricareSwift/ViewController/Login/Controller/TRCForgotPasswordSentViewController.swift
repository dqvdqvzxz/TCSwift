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
        self.navigationItem.title = kForgotPassword
        self.navigationItem.hidesBackButton = true
        
        //UI of outlet
        lblInform1.labelStyle(title: kInform1, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        lblInform2.labelStyle(title: kInform2, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        btnBackToHome.buttonStyle(title: kBackToHome, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnBackToHome(_ sender: Any) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers
        for descView in viewControllers {
            if(descView is TRCLoginViewController){
                self.navigationController!.popToViewController(descView, animated: true)
            }
        }
    }
}
