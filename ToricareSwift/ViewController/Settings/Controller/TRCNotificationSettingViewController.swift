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
    
    var turnOn: String = "TurnOnSwitch"
    
    var section = 3
    
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
    
    //MARK: Action
    func switchReceiveAll(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_ALL)
            section = 3
        }else{
            UserDefaults.kRemoveValue(NOTIF_ALL)
            section = 1
        }
        tblNotify.reloadData()
    }
    
    func switchReceivePharmacy(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_PHARMACY)
        }else{
            UserDefaults.kRemoveValue(NOTIF_PHARMACY)
        }
        tblNotify.reloadData()
    }
    
    func switchReceiveTricare(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_TRICARE)
        }else{
            UserDefaults.kRemoveValue(NOTIF_TRICARE)
        }
        tblNotify.reloadData()
    }
    
    func switchReceiveWeight(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_WEIGHT)
        }else{
            UserDefaults.kRemoveValue(NOTIF_WEIGHT)
        }
        tblNotify.reloadData()
    }
    
    func switchReceiveBreakfast(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_BREAKFAST)
        }else{
            UserDefaults.kRemoveValue(NOTIF_BREAKFAST)
        }
        ///tblNotify.reloadData()
    }
    
    func switchReceiveLunch(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_LUNCH)
        }else{
            UserDefaults.kRemoveValue(NOTIF_LUNCH)
        }
        //tblNotify.reloadData()
    }
    
    func switchReceiveDinner(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_DINNER)
        }else{
            UserDefaults.kRemoveValue(NOTIF_DINNER)
        }
        //tblNotify.reloadData()
    }
    
    func switchReceiveSnack(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.kSetValue(turnOn, NOTIF_SNACK)
        }else{
            UserDefaults.kRemoveValue(NOTIF_SNACK)
        }
        //tblNotify.reloadData()
    }
}

extension TRCNotificationSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if(UserDefaults.kGetValue(NOTIF_ALL) != nil){
            return section
        }else{
            return 1
        }
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
            
            if(UserDefaults.kGetValue(NOTIF_ALL) != nil){
                cell.switchCell.isOn = true
            }else{
                cell.switchCell.isOn = false
            }
            
            cell.switchCell.addTarget(self, action: #selector(switchReceiveAll(switchState:)), for: .valueChanged)
        case 1:
            switch indexPath.row {
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_phamarcy"))
                cell.lblTime.labelStyle()
                
                if(UserDefaults.kGetValue(NOTIF_PHARMACY) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceivePharmacy(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_tricare"))
                cell.lblTime.labelStyle()
                
                if(UserDefaults.kGetValue(NOTIF_TRICARE) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveTricare(switchState:)), for: .valueChanged)
            default:
                break
            }
        case 2:
            switch (indexPath.row){
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "weight"))
                cell.lblTime.labelStyle(title: "7:00")
                
                if(UserDefaults.kGetValue(NOTIF_WEIGHT) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveWeight(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "breakfast"))
                cell.lblTime.labelStyle(title: "8:00")
                
                if(UserDefaults.kGetValue(NOTIF_BREAKFAST) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveBreakfast(switchState:)), for: .valueChanged)
            case 2:
                cell.lblTitle.labelStyle(title: Localizable(value: "lunch"))
                cell.lblTime.labelStyle(title: "12:00")
                
                if(UserDefaults.kGetValue(NOTIF_LUNCH) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveLunch(switchState:)), for: .valueChanged)
            case 3:
                cell.lblTitle.labelStyle(title: Localizable(value: "dinner"))
                cell.lblTime.labelStyle(title: "18:00")
                
                if(UserDefaults.kGetValue(NOTIF_DINNER) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveDinner(switchState:)), for: .valueChanged)
            case 4:
                cell.lblTitle.labelStyle(title: Localizable(value: "snack"))
                cell.lblTime.labelStyle(title: "15:00")
                
                if(UserDefaults.kGetValue(NOTIF_SNACK) != nil){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveSnack(switchState:)), for: .valueChanged)
            default:
                break
            }
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
