//
//  TRCMyPharmacistDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/25/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

protocol TRCMyPharmacistDetailViewControllerDelegate {
    func pushToPharmacistInput()
}


class TRCMyPharmacistDetailViewController: TRCBaseViewController {
    
    @IBOutlet var viewHadData: UIView!
    @IBOutlet var viewNoData: UIView!
    @IBOutlet var viewNoPharmacy: UIView!
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblMemo: UILabel!
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnNoData: UIButton!
    
    @IBOutlet weak var lblNoPharmacy: UILabel!
    @IBOutlet weak var lblNoPharmacy2: UILabel!

    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblPhoneValue: UILabel!
    @IBOutlet weak var lblMailValue: UILabel!
    @IBOutlet weak var lblMemoValue: UILabel!
    
    @IBOutlet weak var btnChange: UIButton!
    
    var dicPharmacist = NSDictionary()
    
    var delegate: TRCMyPharmacistDetailViewControllerDelegate!

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
        configUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configData()
    }
    
    //MARK: Config UI
    func configUI() {
        viewHadData.frame = self.view.bounds
        viewNoData.frame = self.view.bounds
        viewNoPharmacy.frame = self.view.bounds
        
        viewHadData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewNoData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewNoPharmacy.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewHadData.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewNoData.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewNoPharmacy.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        
        viewLeft.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewRight.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        
        lblName.labelStyle(title: Localizable(value: "name"))
        lblPhone.labelStyle(title: Localizable(value: "phone_number"))
        lblMail.labelStyle(title: Localizable(value: "mail_address"))
        lblMemo.labelStyle(title: Localizable(value: "memo"))
        
        lblNameValue.labelStyle()
        lblPhoneValue.labelStyle()
        lblMailValue.labelStyle()
        lblMemoValue.labelStyle()
        
        lblNoData.labelStyle(title: Localizable(value: "my_pharmacist_did_not_set"))
        
        lblNoPharmacy.labelStyle(title: Localizable(value: "my_pharmacist_did_not_set"))
        lblNoPharmacy2.labelStyle(title: Localizable(value: "please_register_pharmacy_first"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblNoPharmacy2.lineBreakMode = .byWordWrapping
        lblNoPharmacy2.numberOfLines = 0
        
        btnChange.buttonStyle(title: Localizable(value: "change_button"))
        
        btnNoData.buttonStyle(title: Localizable(value: "setting_my_pharmacist"))
    }
    
    //MARK: Get data
    func getData(){
        if (_obj.objectAccountInfo != nil && _obj.objectAccountInfo.shopId.isBlank) {
            self.viewNoPharmacy.frame = self.view.bounds
            self.viewNoPharmacy.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(self.viewNoPharmacy)
            
            return
        }
        
        self.showHUD()
        TRCPharmacistRequest().pharmacistInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            self.hideHUD()
            
            do{
                _obj.objectPharmacist = try parseDict(dataResult as! JSONObject) as TRCPharmacist
                
                self.configData()
            }catch{
                ELog("JSONParsin Error: \(error)")
            }
        }) { (error) in
            self.hideHUD()
            ELog(error)
            if(error == RESULT_NO_DATA){
                self.viewNoData.frame = self.view.bounds
                self.viewNoData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.view.addSubview(self.viewNoData)
            }else{
                self.showAlert(error)
            }
        }
    }
    
    func configData(){
        if(_obj.objectPharmacist != nil){
            self.viewHadData.frame = self.view.bounds
            self.viewHadData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(self.viewHadData)
            
            //fill data
            self.lblNameValue.labelStyle(title: _obj.objectPharmacist.name)
            self.lblPhoneValue.labelStyle(title: _obj.objectPharmacist.tel)
            self.lblMailValue.labelStyle(title: _obj.objectPharmacist.email)
            self.lblMemoValue.labelStyle(title: _obj.objectPharmacist.note)
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnChange(_ sender: Any) {
        if(_obj.mode == MODE_REGISTER){
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            if (_obj.objectAccountInfo != nil) {
                vc.pharmacyName = _obj.objectAccountInfo.shopName
            }

            configBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(_obj.mode == MODE_MYPAGE){
            if (delegate != nil) {
                delegate.pushToPharmacistInput()
                return
            }
        }
    }
    
    @IBAction func tapBtnNoData(_ sender: Any) {
        if (delegate != nil) {
            delegate.pushToPharmacistInput()
            return
        }
    }
}
