//
//  TRCPointViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/13/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPointViewController: TRCBaseViewController {

    @IBOutlet weak var tblPoint: UITableView!
    
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
        self.navigationItem.title = kPoint
        
        //table view
        tblPoint.dataSource = self
        tblPoint.delegate = self
        tblPoint.register(UINib(nibName: "TRCAboutAppCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblPoint.tableFooterView = UIView()
    }
}

extension TRCPointViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCAboutAppCell
        
        cell.accessoryType = .disclosureIndicator
        
        switch (indexPath.row) {
        case 0: //storage point
            cell.lblTitle.text = kStoragePoint
            cell.accessoryType = .none
        case 1: //history point
            cell.lblTitle.text = kHistoryPoint
            cell.lblVersion.isHidden = true
        case 2: //used point
            cell.lblTitle.text = kUsedPoint
            cell.lblVersion.isHidden = true
        case 3: //point policy
            cell.lblTitle.text = kPointPolicy
            cell.lblVersion.isHidden = true
        default:
            break
        }
        
        return cell
    }
}

extension TRCPointViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            break
        case 1:
            let vc = TRCPointDetailViewController(nibName: "TRCPointDetailViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
