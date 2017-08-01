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
    
    @IBOutlet weak var tblSearchResult: UITableView!
    
    var mode = String()
    
    var keywordString = "赤堤"
    var arrayResults = NSMutableArray()
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        createTestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        lblInform.labelStyle(title: Localizable(value: "search_by_name"))
        lblKeyword.labelStyle(title: Localizable(value: "キーワード") + "：" + keywordString)
        
        //table view
        tblSearchResult.dataSource = self
        tblSearchResult.delegate = self
        tblSearchResult.register(UINib(nibName: "TRCSearchResultCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tblSearchResult.tableFooterView = UIView()
    }
    

    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        vc.mode = MODE_SKIP
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }

    func createTestData() {
        let firstObject = TRCPharmacyObject()
        firstObject.pharmacyAddress = "東京都世田谷区3-24-4"
        firstObject.pharmacyName = "サンドラッグ赤堤薬局"
        
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
        arrayResults.add(firstObject)
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
        let pharmacyDataObject = arrayResults.object(at: indexPath.row)
        cell.fillData(pharmacyObject: pharmacyDataObject as? TRCPharmacyObject)
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
            vc.mode = MODE_REGISTER
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        }
    }
}
