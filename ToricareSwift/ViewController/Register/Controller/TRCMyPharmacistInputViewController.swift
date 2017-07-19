//
//  TRCMyPharmacistInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacistInputViewController: TRCBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblInform: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tvNote: UITextView!
    
    @IBOutlet weak var btnPharmacistInput: UIButton!
    
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
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
        
        //UI of outlet
        btnPharmacistInput.buttonStyle(title: Localizable(value: "my_pharmacy_setting"))
        
        lblInform.labelStyle(title: Localizable(value: "please_register_your_pharmacist"))
        lblName.labelStyle(title: Localizable(value: "pharmacist_name"))
        lblPhone.labelStyle(title: Localizable(value: "pharmacist_phone"))
        lblEmail.labelStyle(title: Localizable(value: "pharmacist_mail_address"))
        lblNote.labelStyle(title: Localizable(value: "pharmacist_note"))

    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    //MARK: Button Action
    @IBAction func tapBtnPharmacistInput(_ sender: Any) {
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
