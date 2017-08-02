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
        
//        let numbers = Singleton.shared.nc5.viewControllers.count
        
//        print(numbers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation 
        self.navigationItem.title = STRING_SETTING
        
        //table view
        tblSetting.dataSource = self
        tblSetting.delegate = self
        tblSetting.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        listItems = [STRING_SETTING_EMAIL_CHANGE, STRING_SETTING_PASSWORD_CHANGE, STRING_SETTING_OTHER_SERIVCES,
                     STRING_SETTING_NOTIFY, STRING_SETTING_PASSCODE, STRING_SETTING_ABOUT_APP, STRING_SETTING_RESIGN, STRING_SETTING_LOGOUT]
        
        tblSetting.tableFooterView = UIView()
    }
}

extension TRCSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
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
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 1:
            let vc = TRCPasswordChangeViewController(nibName: "TRCPasswordChangeViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 2:
            let vc = TRCLinkedServicesViewController(nibName: "TRCLinkedServicesViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 3:
            let vc = TRCNotificationSettingViewController(nibName: "TRCNotificationSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 4:
            let vc = TRCPasscodeLockSettingViewController(nibName: "TRCPasscodeLockSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
//        case 5:
//            let vc = TRCThemeColorSettingViewController(nibName: "TRCThemeColorSettingViewController", bundle: nil)
//            let backItem = UIBarButtonItem()
//            backItem.title = STRING_BACK
//            navigationItem.backBarButtonItem = backItem
//            _obj.nc5.pushViewController(vc, animated: true)
        case 5:
            let vc = TRCAboutAppViewController(nibName: "TRCAboutAppViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 6:
            let vc = TRCUserLeaveViewController(nibName: "TRCUserLeaveViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 7:
            UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                UserDefaults.kRemoveValue(PASSCODE)
                
                let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
                let navController = UINavigationController(rootViewController: mainVC)
                
                // Back to Home
                self.navigationController?.popToRootViewController(animated: false)
                _obj.tabController.selectedIndex = 0

                UIApplication.shared.keyWindow?.rootViewController = navController
            }, completion: { completed in
                // maybe do something here
            })
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
