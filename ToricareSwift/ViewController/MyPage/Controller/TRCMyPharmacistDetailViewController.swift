//
//  TRCMyPharmacistDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/25/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

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

    @IBOutlet weak var lblNameValue: UILabel!
    @IBOutlet weak var lblPhoneValue: UILabel!
    @IBOutlet weak var lblMailValue: UILabel!
    @IBOutlet weak var lblMemoValue: UILabel!
    
    @IBOutlet weak var btnChange: UIButton!
    
    var dicPharmacist = NSDictionary()
    
    var mode : String = MODE_MYPAGE
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        configUI()
        
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        lblNoData.labelStyle(title: "My薬剤師が設定されていません。")
        
        btnChange.buttonStyle(title: Localizable(value: "change_button"))
        
        btnNoData.buttonStyle(title: Localizable(value: "change_button"))
    }
    
    //MARK: Get data
    func getData(){
        self.showHUD()
        TRCPharmacistRequest().PharmacistInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            self.hideHUD()
            
            self.viewHadData.frame = self.view.bounds
            self.viewHadData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.view.addSubview(self.viewHadData)

            //fill data
            self.lblNameValue.labelStyle(title: dataResult.object(forKey: "name") as? String)
            self.lblPhoneValue.labelStyle(title: dataResult.object(forKey: "tel") as? String)
            self.lblMailValue.labelStyle(title: dataResult.object(forKey: "email") as? String)
            self.lblMemoValue.labelStyle(title: dataResult.object(forKey: "note") as? String)
            
            //set result to dic
            self.dicPharmacist = dataResult
        }) { (error) in
            self.hideHUD()
            ELog(error)
            if(error == "No data"){
                self.viewNoData.frame = self.view.bounds
                self.viewNoData.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.view.addSubview(self.viewNoData)
            }else{
                self.showAlert(error)
            }
        }
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
            let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            vc.dataResult = dicPharmacist
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tapBtnNoData(_ sender: Any) {
        let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
        vc.mode = MODE_MYPAGE
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        _obj.nc5.pushViewController(vc, animated: true)
    }
}
