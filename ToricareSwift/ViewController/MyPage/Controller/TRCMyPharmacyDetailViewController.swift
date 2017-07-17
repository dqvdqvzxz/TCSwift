//
//  TRCMyPharmacyDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacyDetailViewController: TRCBaseViewController {
    
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
    
    @IBOutlet weak var viewGallery: UIView!
    @IBOutlet weak var viewInformation: UIView!
    
    @IBOutlet weak var btnQRCode: UIButton!
    @IBOutlet weak var btnPharmacy: UIButton!
    
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
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        //UI of outlet
        lblAddress.labelStyle(title: nil)
        lblPhone.labelStyle(title: nil)
        lblWorkSchedule.labelStyle(title: nil)
        lblDayOff.labelStyle(title: nil)
        lblWebsite.labelStyle(title: nil)
        
        configMode()
        configData()
    }
    
    func configMode(){
        if(mode == MODE_MYPAGE){
            btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
            btnPharmacy.buttonStyle(title: STRING_CHANGE)
        }else if(mode == MODE_REGISTER){
            btnQRCode.isHidden = true
            btnPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
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
        lblAddressResult.text = "東京都世田谷区3-24-4";
        lblPhoneResult.text = "033321****";
        lblWorkScheduleResult.text = "平日：09:30-19:00";
        lblWorkScheduleDayOffResult.text = "休日：10:30-19:00";
        lblDayOffResult.text = "日・祝日";
        lblWebsiteResult.text = "http://www.aaaa.jp";
        
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnPharmacy(_ sender: Any) {
        if(mode == MODE_MYPAGE){
            //
        }else if(mode == MODE_REGISTER){
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
