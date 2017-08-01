//
//  TRCUserRegistCompleteViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCUserRegistCompleteViewController: TRCBaseViewController {

    @IBOutlet weak var btnQRCode: UIButton!
    @IBOutlet weak var btnUsingApp: UIButton!
    @IBOutlet weak var lblRegisterDone: UILabel!
    @IBOutlet weak var lblPharmacyNotDone: UILabel!
    @IBOutlet weak var lblTakeQRCode: UILabel!
    
    var mode = String()
    
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
        self.navigationItem.title = Localizable(value: "register_complete_title")

        //UI of outlet
        lblRegisterDone.labelStyle(title: Localizable(value: "register_member_complete"))
        
        btnUsingApp.buttonStyle(title: Localizable(value: "use_app"))
        
        configMode()
    }
    
    func configMode(){
        if(mode == MODE_SKIP){
            lblPharmacyNotDone.labelStyle(title: Localizable(value: "please_register_pharmacy_later"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
            lblPharmacyNotDone.lineBreakMode = .byWordWrapping
            lblPharmacyNotDone.numberOfLines = 0
            
            lblTakeQRCode.isHidden = true
            
            btnQRCode.isHidden = true
        }else{
            lblPharmacyNotDone.labelStyle(title: Localizable(value: "my_pharmacy_register_not_done"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
            lblTakeQRCode.labelStyle(title: Localizable(value: "take_qrcode_label"))
            
            btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
        let vc = TRCQRCodeViewController(nibName: "TRCQRCodeViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnUsingApp(_ sender: Any) {
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
        }, completion: { completed in
            // maybe do something here
        })
    }
}
