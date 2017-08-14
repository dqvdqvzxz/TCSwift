//
//  TRCMyPharmacyDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import AlamofireImage

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
    @IBOutlet weak var imgPharmacyView: UIImageView!
    
    @IBOutlet weak var imgNext: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var lblEmpty: UILabel!
    
    var mode : String = MODE_MYPAGE
    var pharmacyData: TRCPharmacy!
    var indexImg = 0
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        if(mode == MODE_MYPAGE) {
            getData()
        }

        configUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        self.showHUD()
//        pharmacyData.pharmacyId
        // for test
        TRCPharmacyRequest().getPharmacy(_obj.objectAccountInfo.shopId, completion: { (data) in
            self.hideHUD()
            guard let data = data else { return }
            guard let pharmacyDict = data.object(forKey: DATA) else { return }
            do {
                self.pharmacyData = try parseDict(pharmacyDict as! JSONObject) as TRCPharmacy
                self.configData()
            }
            catch
            {
                print("JSONParsin Error: \(error)")
            }

        }) { (error) in
            self.hideHUD()
            if (error == RESULT_NO_DATA) {
                self.lblEmpty.isHidden = false
                self.scrollView.isHidden = true
                self.btnQRCode.isHidden = true
                self.btnPharmacy.isHidden = true
            } else {
                self.showAlert(error)
            }
        }
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
        
        lblEmpty.labelStyle(title: Localizable(value: "pharmacy_not_set"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblEmpty.isHidden = true
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
        if (pharmacyData != nil) {
            let gestureNext = UITapGestureRecognizer(target: self, action: #selector(nextImg))
            imgNext.isUserInteractionEnabled = true
            imgNext.addGestureRecognizer(gestureNext)
            
            let gestureBack = UITapGestureRecognizer(target: self, action: #selector(backImg))
            imgBack.isUserInteractionEnabled = true
            imgBack.addGestureRecognizer(gestureBack)
            
            lblPharmacyName.labelStyle(title: nil)
            lblAddressResult.labelStyle(title: nil)
            lblPhoneResult.labelStyle(title: nil)
            lblWorkScheduleResult.labelStyle(title: nil)
            lblWorkScheduleDayOffResult.labelStyle(title: nil)
            lblDayOffResult.labelStyle(title: nil)
            lblWebsiteResult.labelStyle(title: nil)
            
            lblPharmacyName.text = pharmacyData.name
            lblAddressResult.text = pharmacyData.address1 + " " + pharmacyData.address2
            lblPhoneResult.text = pharmacyData.tel
            lblWorkScheduleResult.text = pharmacyData.businessHours
            lblWorkScheduleDayOffResult.text = pharmacyData.holiday
            lblDayOffResult.text = pharmacyData.holiday
            lblWebsiteResult.text = pharmacyData.url
            let imageCount = pharmacyData.images.count
            if (imageCount > 0) {
                setPharmacyImage(urlString: pharmacyData.images[0].origin)
            }
        } else {
            
        }
    }
    
    func setPharmacyImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imgPharmacyView.af_setImage(withURL: url, placeholderImage: nil)
    }
    
    //MARK: Action
    func nextImg() {
        let imageCount = pharmacyData.images.count
        if (indexImg < imageCount - 1) {
            setPharmacyImage(urlString: pharmacyData.images[indexImg].origin)
        }
    }
    
    func backImg() {
        if (indexImg > 0) {
            indexImg -= 1
            setPharmacyImage(urlString: pharmacyData.images[indexImg].origin)
        }
    }
    
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnPharmacy(_ sender: Any) {
        self.registerPharmacy()
    }
    
    func registerPharmacy() {
        self.showHUD()
        TRCPharmacyRequest().registerPharmacy(pharmacyData.pharmacyId, completion: { (data) in
            self.hideHUD()
            self.goNext()
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func goNext() {
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
