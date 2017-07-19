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
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        lblInform.labelStyle(title: Localizable(value: "search_by_name"))
        lblKeyword.labelStyle(title: Localizable(value: "キーワード") + "：" + keywordString)
        //table view
        tblSearchResult.dataSource = self
        tblSearchResult.delegate = self
        tblSearchResult.register(UINib(nibName: "TRCSearchResultCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tblSearchResult.tableFooterView = UIView()
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
        let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
        vc.mode = MODE_REGISTER
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
