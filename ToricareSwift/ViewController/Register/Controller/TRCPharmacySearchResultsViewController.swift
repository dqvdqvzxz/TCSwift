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

    @IBOutlet weak var constraintInformTop: NSLayoutConstraint!
    @IBOutlet weak var tblSearchResult: UITableView!
    var refreshControl = UIRefreshControl()
    
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
    
    var pageNumber = 0

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        prepairSearchData()
        requestPharmarcy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(_obj.mode == MODE_REGISTER){
            _obj.mode = MODE_REGISTER
        }else if(_obj.mode == MODE_REGISTER_MYPAGE){
            _obj.mode = MODE_MYPAGE
        }
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
            return
        }
        
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
            lblInform.text = Localizable(value: "search_by_prefecture")
            
            return
        }
        
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
            lblInform.text = Localizable(value: "search_by_current_location")
            constraintInformTop.constant = 25
            lblKeyword.text = ""
            
            return
        }
    }
    
    func requestPharmarcy() {
        guard let pharmacySearchData = pharmacySearchData else {
            return
        }
        
        if (arrayResults.count % PAGING_NUMBER == 0) {
            pageNumber += 1
            self.showHUD()
            TRCPharmacyRequest().searchPharmacy(pharmacySearchData, "\(pageNumber)", completion: { (data) in
                self.hideHUD()
                
                guard let data = data else { return }
                guard let pharmacyArray = data.object(forKey: DATA) else { return }
                do {
                    let dataResults:[TRCPharmacy] = try parseArray(pharmacyArray as! [JSONObject])
                    dataResults.forEach({ (item) in
                        self.arrayResults.append(item)
                    })
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
                self.pageNumber -= 1
                if (error == RESULT_NO_DATA && self.pageNumber == 0) {
                    self.tblSearchResult.isHidden = true
                    self.lblEmpty.isHidden = false
                } else {
//                    self.showAlert(error)
                }
            }

        } else {
            return
        }
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        if(_obj.mode == MODE_REGISTER){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
        }else if(_obj.mode == MODE_MYPAGE){
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
        
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: Localizable(value: "pull_to_refresh"))
        refreshControl.tintColor = UIColor.init(hexString: MAIN_COLOR)
        tblSearchResult.addSubview(refreshControl)
    }
    
    func refresh(sender: AnyObject){
        pageNumber = 0
        arrayResults.removeAll()
        requestPharmarcy()
        refreshControl.endRefreshing()
    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        vc.hidesBottomBarWhenPushed = true
        _obj.mode = MODE_SKIP
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
        if(_obj.mode == MODE_REGISTER){
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.pharmacyData = arrayResults[indexPath.row]
            vc.hidesBottomBarWhenPushed = true
            configBackButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(_obj.mode == MODE_MYPAGE){
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.pharmacyData = arrayResults[indexPath.row]
            vc.hidesBottomBarWhenPushed = true
            _obj.mode = MODE_REGISTER_MYPAGE
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = arrayResults.count - 1
        if indexPath.row == lastElement {
            requestPharmarcy()
        }
    }
}
