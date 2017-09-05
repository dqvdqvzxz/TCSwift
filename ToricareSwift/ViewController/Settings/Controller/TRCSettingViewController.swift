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
        self.navigationItem.title = STRING_SETTING
        
        //table view
        setGrayColorForView(tblSetting)
        
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
        
        self.setGrayColorForView(cell)
        cell.textLabel?.labelStyle(title: self.listItems?[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

extension TRCSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc = UIViewController()
        
        switch (indexPath.row) {
        case 0:
            vc = TRCEmailChangeInputViewController(nibName: "TRCEmailChangeInputViewController", bundle: nil)
            break
        case 1:
            vc = TRCPasswordChangeViewController(nibName: "TRCPasswordChangeViewController", bundle: nil)
            break
        case 2:
            vc = TRCLinkedServicesViewController(nibName: "TRCLinkedServicesViewController", bundle: nil)
            break
        case 3:
            vc = TRCNotificationSettingViewController(nibName: "TRCNotificationSettingViewController", bundle: nil)
            break
        case 4:
            vc = TRCPasscodeLockSettingViewController(nibName: "TRCPasscodeLockSettingViewController", bundle: nil)
            break
        case 5:
            vc = TRCAboutAppViewController(nibName: "TRCAboutAppViewController", bundle: nil)
            break
        case 6:
            vc = TRCUserLeaveViewController(nibName: "TRCUserLeaveViewController", bundle: nil)
            break
        case 7:
            let alert = UIAlertController(title: nil,
                                          message: Localizable(value: "really_logout_message"),
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            // add the action
            alert.addAction(UIAlertAction(title: Localizable(value: "cancel"),
                                          style: UIAlertActionStyle.cancel,
                                          handler: { action in
                                            
            }))
            alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                          style: UIAlertActionStyle.default,
                                          handler: { action in
                                            TRCTokenRequest().deleteToken(UserDefaults.getUD(ACCESS_TOKEN) as! String, completion: { (data) in
                                                UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                                                    
                                                    UserDefaults.clearValueWhenLogout()
                                                    
                                                    //reset struct
                                                    _obj.clearObject()
                                                    
                                                    let mainVC = TRCPreLoginViewController(nibName: "TRCPreLoginViewController", bundle: nil)
                                                    let navController = UINavigationController(rootViewController: mainVC)
                                                    
                                                    UIApplication.shared.keyWindow?.rootViewController = navController
                                                }, completion: { completed in
                                                    // maybe do something here
                                                })
                                            }, failed: { (error) in
                                                self.hideHUD()
                                                self.showAlert(error)
                                                ELog(error)
                                            })
            }))
            // show the alert
            self.present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
        
        configBackButton()
        _obj.nc5.pushViewController(vc, animated: true)
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
