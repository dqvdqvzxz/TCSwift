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
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localizable(value: "register_complete_title")
        configUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI 
    func configUI(){
        lblRegisterDone.labelStyle(title: Localizable(value: "register_member_complete"))
        lblPharmacyNotDone.labelStyle(title: Localizable(value: "my_pharmacy_register_not_done"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
        lblTakeQRCode.labelStyle(title: Localizable(value: "take_qrcode_label"))
        
        btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
        btnUsingApp.buttonStyle(title: Localizable(value: "use_app"))
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnUsingApp(_ sender: Any) {
        let vc = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
