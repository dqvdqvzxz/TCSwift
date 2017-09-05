//
//  TRCMyPharmacyDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TRCMyPharmacyDetailViewControllerDelegate {
    func pushtoSearchView()
    func pushtoQRCodeView(_ mode: String)
}

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
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var contraintHeightViewMain: NSLayoutConstraint!
    @IBOutlet weak var contraintTopBtnQRCode: NSLayoutConstraint!
    @IBOutlet weak var contraintTopBtnSearch: NSLayoutConstraint!
    @IBOutlet weak var imgPharmacyView: UIImageView!
    
    @IBOutlet weak var imgNext: UIImageView!
    @IBOutlet weak var imgBack: UIImageView!
    @IBOutlet weak var lblEmpty: UILabel!
    @IBOutlet weak var btnNoPharmacy: UIButton!
    
    var pharmacyData: TRCPharmacy!
    var indexImg = 0
    
    var delegate: TRCMyPharmacyDetailViewControllerDelegate!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()

        if(_obj.mode == MODE_MYPAGE) {
            getData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(_obj.mode == MODE_REGISTER_MYPAGE){
            _obj.tabController.tabBar.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        if (_obj.objectAccountInfo != nil && _obj.objectAccountInfo.shopId.isBlank) {
            showEmptyLabel()
            return
        }
        
        self.showHUD()
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
                DLog("JSONParsin Error: \(error)")
            }

        }) { (error) in
            self.hideHUD()
            if (error == RESULT_NO_DATA) {
                self.showEmptyLabel()
            } else {
                self.showAlert(error)
            }
        }
    }

    func showEmptyLabel() {
        self.lblEmpty.isHidden = false
        self.btnNoPharmacy.isHidden = false
        self.scrollView.isHidden = true
        self.btnQRCode.isHidden = true
        self.btnPharmacy.isHidden = false
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation 
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
//        viewMain.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        setGrayColorForView(viewMain)
        
        //UI of outlet
        lblAddress.labelStyle(title: Localizable(value: "address"))
        lblPhone.labelStyle(title: Localizable(value: "phone_number"))
        lblWorkSchedule.labelStyle(title: Localizable(value: "business_time"))
        lblDayOff.labelStyle(title: Localizable(value: "day_off"))
        lblWebsite.labelStyle(title: Localizable(value: "website"))
        
        lblEmpty.labelStyle(title: Localizable(value: "pharmacy_not_set"))
        lblEmpty.isHidden = true
        btnNoPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
        btnNoPharmacy.isHidden = true
        
        //hide button qr
        btnQRCode.isHidden = true
        
        configMode()
        
        configData()
    }
    
    override func viewDidLayoutSubviews() {
        let heightbottomContent = (btnPharmacy.frame.origin.y + btnPharmacy.frame.size.height + 10)
        let selfViewHeight = self.view.frame.size.height
        if(_obj.mode == MODE_REGISTER_MYPAGE && heightbottomContent <= selfViewHeight){
            contraintHeightViewMain.constant = selfViewHeight
            if let newContraintTopBtnSearch: NSLayoutConstraint = contraintTopBtnSearch {
                newContraintTopBtnSearch.isActive = false
            }
            
            self.view.layoutIfNeeded()
        }else{
            contraintHeightViewMain.constant = heightbottomContent
        }
    }
    
    func configMode(){
        if(_obj.mode == MODE_REGISTER){
            constraintTop.constant = 74
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
            btnPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
        }else if(_obj.mode == MODE_REGISTER_MYPAGE){
            constraintTop.constant = 74
            btnPharmacy.buttonStyle(title: Localizable(value: "register_my_pharmacy"))
        }else if(_obj.mode == MODE_MYPAGE){
            if (_obj.objectAccountInfo != nil && _obj.objectAccountInfo.shopId.isBlank) {
                btnPharmacy.buttonStyle(title: Localizable(value: "setting_my_pharmacy"))
            } else {
                btnPharmacy.buttonStyle(title: Localizable(value: "change_button"))
            }
            if (_obj.objectAccountInfo != nil) {
                if (_obj.objectAccountInfo.shopStatus.isBlank || _obj.objectAccountInfo.shopStatus == REGISTER_FALSE) {
                    btnQRCode.buttonStyle(title: Localizable(value: "read_qrcode"))
                    btnQRCode.isHidden = false
                }
            }
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
            
            lblPharmacyName.text = pharmacyData.name
            lblAddressResult.text = pharmacyData.address1 + " " + pharmacyData.address2
            lblPhoneResult.text = pharmacyData.tel
            lblWorkScheduleResult.text = getValueAtIndex(stringValue: pharmacyData.businessHours, index: 0)
            lblWorkScheduleDayOffResult.text = getValueAtIndex(stringValue: pharmacyData.businessHours, index: 1)
            lblDayOffResult.text = getValueAtIndex(stringValue: pharmacyData.holiday, index: 0)
            lblWebsiteResult.labelStyle(title: pharmacyData.url, fontSize: LABEL_FONT_SIZE, isBold: false, textColor: URL_COLOR)
            lblWebsiteResult.makeLineSpacing()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openURL))
            lblWebsiteResult.gestureRecognizers = [tapGesture]
            lblWebsiteResult.isUserInteractionEnabled = true
            
            let imageCount = pharmacyData.images.count
            if (imageCount == 0 || imageCount == 1) {
                imgNext.isHidden = true
                imgBack.isHidden = true
            }
            
            if (imageCount > 0) {
                setPharmacyImage(urlString: pharmacyData.images[0].origin)
            } else {
                imgPharmacyView.image = #imageLiteral(resourceName: "no_image")
            }
        } else {
            
        }
    }
    
    func getValueAtIndex(stringValue: String, index: Int) -> String {
        let stringSeparator = "\r\n"
        let stringObject = NSString(string: stringValue)
        if (stringValue.isBlank || stringObject.range(of: stringSeparator).location == NSNotFound) {
            return ""
        }
        
        let stringArray = stringObject.components(separatedBy: stringSeparator)
        if (stringArray.count == 2) {
            return stringArray[index]
        }
        
        return ""
    }
    
    func openURL() {
        if (pharmacyData != nil) {
            let url = URL(string: pharmacyData.url)!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func setPharmacyImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imgPharmacyView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "no_image"))
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
        if (delegate != nil) {
            delegate.pushtoQRCodeView(MODE_REGISTER_MYPAGE)
            return
        }
    }
    
    @IBAction func tapBtnPharmacy(_ sender: Any) {
        goNext()
    }
    
    @IBAction func tapBtnNoPharmacy(_ sender: Any) {
        self.goSearchPharmacy()
    }
    
    func registerPharmacy() {
        self.showHUD()
        TRCPharmacyRequest().registerPharmacy(pharmacyData.pharmacyId, completion: { (data) in
            self.hideHUD()
            self.goInputPharmacist()
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func goInputPharmacist() {
        if (_obj.objectAccountInfo != nil) {
            _obj.objectAccountInfo.shopId = pharmacyData.pharmacyId
            _obj.objectAccountInfo.shopName = pharmacyData.name
            _obj.objectAccountInfo.shopStatus = REGISTER_FALSE
        }
        
        if (_obj.mode == MODE_REGISTER) {
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            vc.pharmacyName = pharmacyData.name

            configBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (_obj.mode == MODE_REGISTER_MYPAGE) {
            let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
            configBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func goNext() {
        if(_obj.mode == MODE_REGISTER){
            self.registerPharmacy()
        }else if(_obj.mode == MODE_REGISTER_MYPAGE){
            self.registerPharmacy()
        }else if(_obj.mode == MODE_MYPAGE){
            if (_obj.objectAccountInfo != nil && _obj.objectAccountInfo.shopId.isBlank) {
                goSearchPharmacy()
                return
            }

            let alert = UIAlertController(title: nil,
                                          message: Localizable(value: "confirm_change_pharmacy"),
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            // add the action
            alert.addAction(UIAlertAction(title: Localizable(value: "cancel"),
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil))
            alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                          style: UIAlertActionStyle.default,
                                          handler: { action in
                                            self.goSearchPharmacy()
            }))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    func goSearchPharmacy() {
        if (delegate != nil) {
            delegate.pushtoSearchView()
            return
        }
    }
}
