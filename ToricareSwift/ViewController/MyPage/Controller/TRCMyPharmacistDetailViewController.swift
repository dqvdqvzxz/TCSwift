//
//  TRCMyPharmacistDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/25/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacistDetailViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblMemo: UILabel!

    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblPhoneValue: UILabel!
    @IBOutlet weak var lblMailValue: UILabel!
    @IBOutlet weak var lblMemoValue: UILabel!
    
    @IBOutlet weak var btnChange: UIButton!
    
    var mode = String()
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configUI()
        
    }
    
    //MARK: Config UI
    func configUI() {
        lblName.labelStyle(title: Localizable(value: "name"))
        lblPhone.labelStyle(title: Localizable(value: "phone_number"))
        lblMail.labelStyle(title: Localizable(value: "mail_address"))
        lblMemo.labelStyle(title: Localizable(value: "memo"))
        
        lblNameValue.labelStyle(title: "鈴木太郎")
        lblPhoneValue.labelStyle(title: "03-1111-2222")
        lblMailValue.labelStyle(title: "suzuki@xxx.co.jp")
        lblMemoValue.labelStyle(title: "月曜日休暇")
        
        btnChange.buttonStyle(title: Localizable(value: "change_button"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Button Action
    @IBAction func tapBtnChange(_ sender: Any) {
        if(mode == MODE_REGISTER){
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            vc.mode = MODE_REGISTER
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        }
    }
}
