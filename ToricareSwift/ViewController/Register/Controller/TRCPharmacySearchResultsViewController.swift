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
        
        //table view
        tblSearchResult.dataSource = self
        tblSearchResult.delegate = self
        tblSearchResult.register(UINib(nibName: "TRCSearchResultCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblSearchResult.tableFooterView = UIView()
    }
}

extension TRCPharmacySearchResultsViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCSearchResultCell
        
        return cell
    }
}

extension TRCPharmacySearchResultsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
        vc.mode = "Register"
        let backItem = UIBarButtonItem()
        backItem.title = kBackButton
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
