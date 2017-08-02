//
//  TRCMyPharmacyDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacyDetailViewController: TRCBaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var lblPharmacyName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblAddressResult: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblPhoneResult: UILabel!
    @IBOutlet weak var lblWorkSchedule: UILabel!
    @IBOutlet weak var lblWorkScheduleResult: UILabel!
    @IBOutlet weak var lblWorkScheduleDayOffResult: UILabel!
    @IBOutlet weak var lblDayOff: UILabel!
    @IBOutlet weak var lblDayOffResult: UILabel!
    @IBOutlet weak var lblWebsite: UILabel!
    @IBOutlet weak var lblWebsiteResult: UILabel!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var viewInformation: UIView!
    
    @IBOutlet weak var btnQRCode: UIButton!
    @IBOutlet weak var btnPharmacy: UIButton!
    
    @IBOutlet weak var contraintBottomScrollView: NSLayoutConstraint!
    
    var mode : String = MODE_MYPAGE
    
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
        
        //UI of outlet
        lblAddress.labelStyle(title: Localizable(value: "address"))
        lblPhone.labelStyle(title: Localizable(value: "phone_number"))
        lblWorkSchedule.labelStyle(title: Localizable(value: "business_time"))
        lblDayOff.labelStyle(title: Localizable(value: "day_off"))
        lblWebsite.labelStyle(title: Localizable(value: "website"))
        
        configMode()
        
        configData()
    }
    
    func configMode(){
        if(mode == MODE_REGISTER){
            btnQRCode.isHidden = true
            contraintBottomScrollView.constant = 54
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
            btnPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
        }else if(mode == MODE_REGISTER_MYPAGE){
            btnQRCode.isHidden = true
            contraintBottomScrollView.constant = 54
            btnPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
        }else if(mode == MODE_MYPAGE){
            btnQRCode.isHidden = true
            contraintBottomScrollView.constant = 54
            btnPharmacy.buttonStyle(title: Localizable(value: "change_button"))
        }
    }
    
    //MARK: Config Data
    func configData(){
        lblPharmacyName.labelStyle(title: nil)
        lblAddressResult.labelStyle(title: nil)
        lblPhoneResult.labelStyle(title: nil)
        lblWorkScheduleResult.labelStyle(title: nil)
        lblWorkScheduleDayOffResult.labelStyle(title: nil)
        lblDayOffResult.labelStyle(title: nil)
        lblWebsiteResult.labelStyle(title: nil)
        
        // Test data
        lblAddressResult.text = "東京都世田谷区3-24-4"
        lblPhoneResult.text = "033321****"
        lblWorkScheduleResult.text = "平日：09:30-19:00"
        lblWorkScheduleDayOffResult.text = "休日：10:30-19:00"
        lblDayOffResult.text = "日・祝日"
        lblWebsiteResult.text = "http://www.aaaa.jp"
        
    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnPharmacy(_ sender: Any) {
        if(mode == MODE_REGISTER){
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            vc.mode = MODE_REGISTER
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_REGISTER_MYPAGE){
            let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
            vc.mode = MODE_REGISTER_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let alert = UIAlertController(title: nil,
                                          message: "My薬局を変更すると、現在My薬局として登録している薬局からのメッセージやその他関連データが全て削除されますがよろしいですか？",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            // add the action
            alert.addAction(UIAlertAction(title: Localizable(value: "cancel"),
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil))
            alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                          style: UIAlertActionStyle.default,
                                          handler: { action in
                                            let vc = TRCPharmacySearchViewController(nibName: "TRCPharmacySearchViewController", bundle: nil)
                                            vc.mode = MODE_MYPAGE
                                            let backItem = UIBarButtonItem()
                                            backItem.title = STRING_BACK
                                            self.navigationItem.backBarButtonItem = backItem
                                            _obj.nc5.pushViewController(vc, animated: true)
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}
