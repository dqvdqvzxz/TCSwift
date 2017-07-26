//
//  TRCNotificationSettingViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationSettingViewController: TRCBaseViewController {

    @IBOutlet weak var tblNotify: UITableView!
    
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
        self.navigationItem.title = STRING_SETTING_NOTIFY
        
        //table view
        tblNotify.dataSource = self
        tblNotify.delegate = self
        tblNotify.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblNotify.tableFooterView = UIView()
    }
}

extension TRCNotificationSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 5
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCLinkedServiceCell
        
        switch (indexPath.section) {
        case 0:
            cell.lblTitle.labelStyle(title: Localizable(value: "receive"))
            cell.lblTime.labelStyle()
            break
        case 1:
            switch indexPath.row {
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_phamarcy"))
                cell.lblTime.labelStyle()
                break
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_tricare"))
                cell.lblTime.labelStyle()
                break

            default:
                break
            }
            break
        case 2:
            switch indexPath.row {
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "weight"))
                cell.lblTime.labelStyle(title: "7:00")
                break
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "breakfast"))
                cell.lblTime.labelStyle(title: "8:00")
                break
            case 2:
                cell.lblTitle.labelStyle(title: Localizable(value: "lunch"))
                cell.lblTime.labelStyle(title: "12:00")
                break
            case 3:
                cell.lblTitle.labelStyle(title: Localizable(value: "dinner"))
                cell.lblTime.labelStyle(title: "18:00")
                break
            case 4:
                cell.lblTitle.labelStyle(title: Localizable(value: "snack"))
                cell.lblTime.labelStyle(title: "15:00")
                break
      
            default:
                break
            }
            break

        default:
            break
        }
        
        return cell
    }
}

extension TRCNotificationSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}
