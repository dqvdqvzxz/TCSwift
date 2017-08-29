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
    @IBOutlet weak var constraintTopPharmacyNotDone: NSLayoutConstraint!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI 
    func configUI(){
        //navigation
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.title = _obj.mode == MODE_REGISTER_MYPAGE ? Localizable(value: "my_pharmacy_setting") : Localizable(value: "register_complete_title")

        //UI of outlet
        lblRegisterDone.labelStyle(title: _obj.mode == MODE_REGISTER_MYPAGE ? Localizable(value: "select_pharmacy_done") : Localizable(value: "register_member_complete"))
        
        configMode()
    }
    
    func configMode(){
        if(_obj.mode == MODE_SKIP){
            lblPharmacyNotDone.labelStyle(title: Localizable(value: "please_register_pharmacy_later"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_COLOR)
            lblPharmacyNotDone.lineBreakMode = .byWordWrapping
            lblPharmacyNotDone.numberOfLines = 0
            lblPharmacyNotDone.makeLineSpacing()
            constraintTopPharmacyNotDone.constant = 10
            lblTakeQRCode.isHidden = true
            
            btnQRCode.isHidden = true
            btnUsingApp.buttonStyle(title: Localizable(value: "use_app"))
        }else if(_obj.mode == MODE_REGISTER_MYPAGE){
            lblPharmacyNotDone.labelStyle(title: Localizable(value: "my_pharmacy_register_not_done"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
            lblTakeQRCode.labelStyle(title: Localizable(value: "pharmacy_register_done"))
            lblTakeQRCode.makeLineSpacing()
            btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
            btnUsingApp.buttonStyle(title: Localizable(value: "back_to_mypage"))
        }else{
            lblPharmacyNotDone.labelStyle(title: Localizable(value: "my_pharmacy_register_not_done"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
            lblTakeQRCode.labelStyle(title: Localizable(value: "take_qrcode_label"))
            lblTakeQRCode.makeLineSpacing()
            btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
            btnUsingApp.buttonStyle(title: Localizable(value: "use_app"))
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
        if(_obj.mode == MODE_REGISTER_MYPAGE){
            let vc = TRCQRCodeViewController(nibName: "TRCQRCodeViewController", bundle: nil)
            vc.hidesBottomBarWhenPushed = true
            vc.mode = _obj.mode
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        }else{
            let vc = TRCQRCodeViewController(nibName: "TRCQRCodeViewController", bundle: nil)
            vc.mode = _obj.mode
            configBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tapBtnUsingApp(_ sender: Any) {
        if(_obj.mode == MODE_REGISTER_MYPAGE){
            let viewControllers: [UIViewController] = _obj.nc5.viewControllers
            for descView in viewControllers {
                if(descView is TRCMyPageViewController){
                    _obj.nc5.popToViewController(descView, animated: true)
                }
            }
        }else{
            //init tabbar controller
            _obj.initTabbarController()

            UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
            }, completion: { completed in
                // maybe do something here
            })
        }
    }
}
