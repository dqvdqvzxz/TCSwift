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
        self.navigationItem.title = kMyPharmcy
        
        //UI of outlet
        lblAddress.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblPhone.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblWorkSchedule.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblDayOff.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblWebsite.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        
        configMode()
    }
    
    func configMode(){
        if(mode == "MyPage"){
            btnQRCode.buttonStyle(title: kQRCode, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
            btnPharmacy.buttonStyle(title: kChangePharmacy, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        }else if(mode == "Register"){
            btnQRCode.isHidden = true
            btnPharmacy.buttonStyle(title: kRegisterPharmacy, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        }
    }
    
    //MARK: Config Data
    func configData(){
        lblPharmacyName.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblAddressResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblPhoneResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblWorkScheduleResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblWorkScheduleDayOffResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblDayOffResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
        lblWebsiteResult.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: BUTTON_TITLE_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnPharmacy(_ sender: Any) {
        if(mode == "MyPage"){
            //
        }else if(mode == "Register"){
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
