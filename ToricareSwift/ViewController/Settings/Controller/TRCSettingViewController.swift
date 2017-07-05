//
//  TRCSettingViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSettingViewController: TRCBaseViewController {

    @IBOutlet weak var tblSetting: UITableView!
    
    var listItems: [String]?
    
    //MARK: ViewController
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
        self.navigationItem.title = kTitleSetting
        
        //table view
        tblSetting.dataSource = self
        tblSetting.delegate = self
        tblSetting.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        listItems = [kChangeEmail, kChangePass, kLinkedService, kNotification, kPasscode, kTheme, kAboutApp, kUserLeave, kLogout]
        
        tblSetting.tableFooterView = UIView()
    }
}

extension TRCSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.listItems?[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension TRCSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0:
            let vc = TRCEmailChangeInputViewController(nibName: "TRCEmailChangeInputViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = TRCPasswordChangeViewController(nibName: "TRCPasswordChangeViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = TRCLinkedServicesViewController(nibName: "TRCLinkedServicesViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = TRCNotificationSettingViewController(nibName: "TRCNotificationSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = TRCPasscodeLockSettingViewController(nibName: "TRCPasscodeLockSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = TRCThemeColorSettingViewController(nibName: "TRCThemeColorSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 6:
            let vc = TRCAboutAppViewController(nibName: "TRCAboutAppViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 7:
            let vc = TRCUserLeaveViewController(nibName: "TRCUserLeaveViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        case 8:
            //logout
            break
        default:
            break
        }
    }
}
