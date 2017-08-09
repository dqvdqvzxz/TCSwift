//
//  TRCPharmacySearchResultsViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPharmacySearchResultsViewController: TRCBaseViewController {

    @IBOutlet weak var viewKeyword: UILabel!
    
    @IBOutlet weak var lblInform: UILabel!
    @IBOutlet weak var lblKeyword: UILabel!
    @IBOutlet weak var lblEmpty: UILabel!

    @IBOutlet weak var tblSearchResult: UITableView!
    
    var mode = String()
    
    var keywordString = "赤堤"
    var arrayResults: [TRCPharmacy] = []
    {
        didSet
        {
            DispatchQueue.main.async {
                self.tblSearchResult.reloadData()
            }
        }
    }

    var pharmacySearchData: TRCPharmacySearchData!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        prepairSearchData()
        requestPharmarcy()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepairSearchData() {
        pharmacySearchData = TRCPharmacySearchData()
        DLog(pharmacySearchData)
        
        if (UserDefaults.getUD(SEARCH_KEYWORD) != nil && !(UserDefaults.getUD(SEARCH_KEYWORD) as! String).isBlank) {
            let shopName = Global().convertObjectToString(UserDefaults.getUD(SEARCH_KEYWORD))
            if (!shopName.isBlank) {
                pharmacySearchData.shopName = shopName
            }
            lblInform.text = Localizable(value: "search_by_name")
            lblKeyword.text = Localizable(value: "キーワード") + "：" + shopName
            //SEARCH_TAB
        }
        
        if (UserDefaults.getUD(SEARCH_TAB) != nil && (UserDefaults.getUD(SEARCH_TAB) as! String) == "0") {
            if (UserDefaults.getUD(SEARCH_PREFECTURE) != nil) {
                let prefecture = Global().convertObjectToString(UserDefaults.getUD(SEARCH_PREFECTURE))
                let prefectureName = Global().convertObjectToString(UserDefaults.getUD(SEARCH_PREFECTURE_NAME))
                if (!prefecture.isBlank) {
                    pharmacySearchData.prefectureId = prefecture
                    lblKeyword.text = prefectureName
                }
                if (UserDefaults.getUD(SEARCH_TOWN) != nil) {
                    let city = Global().convertObjectToString(UserDefaults.getUD(SEARCH_TOWN))
                    if (!city.isBlank) {
                        pharmacySearchData.cityId = city
                        let cityName = Global().convertObjectToString(UserDefaults.getUD(SEARCH_TOWN_NAME))
                        lblKeyword.text = prefectureName + " / " + cityName
                    }
                }
                lblInform.text = pharmacySearchData.shopName.isBlank ? Localizable(value: "search_by_prefecture") : Localizable(value: "キーワード") + "：" + pharmacySearchData.shopName
                
                return
            }
        } else if (UserDefaults.getUD(SEARCH_TAB) != nil && (UserDefaults.getUD(SEARCH_TAB) as! String) == "1") {
            if (UserDefaults.getUD(SEARCH_LAT) != nil) {
                let latValue = Global().convertObjectToString(UserDefaults.getUD(SEARCH_LAT))
                if (!latValue.isBlank) {
                    pharmacySearchData.lat = latValue
                }
                if (UserDefaults.getUD(SEARCH_LON) != nil) {
                    let longValue = Global().convertObjectToString(UserDefaults.getUD(SEARCH_LON))
                    if (!longValue.isBlank) {
                        pharmacySearchData.long = longValue
                    }
                }
                lblInform.text = pharmacySearchData.shopName.isBlank ? Localizable(value: "search_by_current_location") : Localizable(value: "キーワード") + "：" + pharmacySearchData.shopName
                lblKeyword.text = Localizable(value: "gps_1km_pharmacy")
                
                return
            }
        }
        
//        } else if (UserDefaults.getUD(SEARCH_PREFECTURE) != nil) {
//            let prefecture = Global().convertObjectToString(UserDefaults.getUD(SEARCH_PREFECTURE))
//            if (!prefecture.isBlank) {
//                pharmacySearchData.prefectureId = prefecture
//                lblKeyword.text = prefecture
//            }
//            if (UserDefaults.getUD(SEARCH_TOWN) != nil) {
//                let city = Global().convertObjectToString(UserDefaults.getUD(SEARCH_TOWN))
//                if (!city.isBlank) {
//                    pharmacySearchData.cityId = city
//                    lblKeyword.text = prefecture + "/" + city
//                }
//            }
//            lblInform.text = Localizable(value: "search_by_prefecture")
//
//            return
//        } else if (UserDefaults.getUD(SEARCH_LAT) != nil) {
//            let latValue = Global().convertObjectToString(UserDefaults.getUD(SEARCH_LAT))
//            if (!latValue.isBlank) {
//                pharmacySearchData.lat = latValue
//            }
//            if (UserDefaults.getUD(SEARCH_LON) != nil) {
//                let longValue = Global().convertObjectToString(UserDefaults.getUD(SEARCH_LON))
//                if (!longValue.isBlank) {
//                    pharmacySearchData.long = longValue
//                }
//            }
//            lblInform.text = Localizable(value: "search_by_current_location")
//        }
    }
    
    func requestPharmarcy() {
        guard let pharmacySearchData = pharmacySearchData else {
            return
        }
        self.showHUD()
        TRCPharmacyRequest().searchPharmacy(pharmacySearchData, completion: { (data) in
            self.hideHUD()
            
            guard let data = data else { return }
            guard let pharmacyArray = data.object(forKey: DATA) else { return }
            do {
                self.arrayResults = try parseArray(pharmacyArray as! [JSONObject])
            }
            catch
            {
                print("JSONParsin Error: \(error)")
            }
            if (self.arrayResults.count == 0) {
                self.tblSearchResult.isHidden = true
                self.lblEmpty.isHidden = false
            }
        }) { (error) in
            self.hideHUD()
            if (error == RESULT_NO_DATA) {
                self.tblSearchResult.isHidden = true
                self.lblEmpty.isHidden = false
            } else {
                self.showAlert(error)
            }
        }
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        if(mode == MODE_REGISTER){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
        }else if(mode == MODE_MYPAGE){
            //
        }
        
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")

        //UI of outlet
        lblInform.labelStyle()//title: Localizable(value: "search_by_name"))
        lblKeyword.labelStyle()//title: Localizable(value: "キーワード") + "：" + keywordString)
        
        //table view
        tblSearchResult.dataSource = self
        tblSearchResult.delegate = self
        tblSearchResult.register(UINib(nibName: "TRCSearchResultCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tblSearchResult.tableFooterView = UIView()
        
        lblEmpty.labelStyle(title: Localizable(value: "empty_pharmacy_search"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblEmpty.isHidden = true
    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        vc.mode = MODE_SKIP
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
}

extension TRCPharmacySearchResultsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCSearchResultCell
        let pharmacyDataObject = arrayResults[indexPath.row]
        cell.fillData(pharmacyObject: pharmacyDataObject)
        return cell
    }
}

extension TRCPharmacySearchResultsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if(mode == MODE_REGISTER){
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.pharmacyData = arrayResults[indexPath.row]
            vc.mode = MODE_REGISTER
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.pharmacyData = arrayResults[indexPath.row]
            vc.mode = MODE_REGISTER_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        }
    }
}
