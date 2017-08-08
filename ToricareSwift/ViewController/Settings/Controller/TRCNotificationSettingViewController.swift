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
    
    @IBOutlet weak var btnSave: UIButton!
    
    var turnOn: String = "1"
    var turnOff: String = "0"
    
    var section = 3
    
    var dataResult = NSDictionary()
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_SETTING_NOTIFY
        
        btnSave.buttonStyle(title: STRING_CHANGE)
        
        //table view
        tblNotify.dataSource = self
        tblNotify.delegate = self
        tblNotify.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblNotify.tableFooterView = UIView()
    }
    
    //MARK: Get data
    func getData(){
        self.showHUD()
        TRCNotificationRequest().NotificationInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            self.hideHUD()
            
            //set result to dic
            self.dataResult = dataResult
            
            self.configUI()

        }) { (error) in
            self.hideHUD()
            ELog(error)
            self.showAlert(error)
        }
    }
    
    //MARK: Button action
    @IBAction func tapBtnSave(_ sender: Any) {
//        self.showHUD()
//        TRCNotificationRequest().NotificationInfoChange(UserDefaults.getUD(NOTIF_ALL) as? String, UserDefaults.getUD(NOTIF_PHARMACY) as? String, UserDefaults.getUD(NOTIF_TRICARE) as? String, UserDefaults.getUD(NOTIF_WEIGHT) as? String, UserDefaults.getUD(NOTIF_BREAKFAST) as? String, UserDefaults.getUD(NOTIF_LUNCH) as? String, UserDefaults.getUD(NOTIF_DINNER) as? String, isReceivedSnack: UserDefaults.getUD(NOTIF_SNACK) as? String, <#T##weightTime: String##String#>, <#T##breakfastTime: String##String#>, <#T##lunchTime: String##String#>, <#T##dinnerTime: String##String#>, <#T##snackTime: String##String#>, completion: {(data) in
//            let dataResult = data?.object(forKey: DATA) as! NSDictionary
//            self.hideHUD()
//            
//            //set result to dic
//            self.dataResult = dataResult
//            
//            self.configUI()
//            
//        }) { (error) in
//            self.hideHUD()
//            ELog(error)
//            self.showAlert(error)
//        }
    }
    
    //MARK: Action
    func switchReceiveAll(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_ALL)
            section = 3
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_ALL)
            section = 1
        }
        tblNotify.reloadData()
    }
    
    func switchReceivePharmacy(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_PHARMACY)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_PHARMACY)
        }
    }
    
    func switchReceiveTricare(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_TRICARE)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_TRICARE)
        }
    }
    
    func switchReceiveWeight(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_WEIGHT)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_WEIGHT)
        }
    }
    
    func switchReceiveBreakfast(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_BREAKFAST)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_BREAKFAST)
        }
    }
    
    func switchReceiveLunch(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_LUNCH)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_LUNCH)
        }
    }
    
    func switchReceiveDinner(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_DINNER)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_DINNER)
        }
    }
    
    func switchReceiveSnack(switchState: UISwitch){
        if(switchState.isOn){
            UserDefaults.saveUD(turnOn, NOTIF_SNACK)
        }else{
            UserDefaults.saveUD(turnOff, NOTIF_SNACK)
        }
    }
}

extension TRCNotificationSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if(dataResult.object(forKey: "is_pushed") as? Int == 1){
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
            
            if(dataResult.object(forKey: "is_pushed") as? Int == 1){
                cell.switchCell.isOn = true
                UserDefaults.saveUD(turnOn, NOTIF_ALL)
            }else{
                cell.switchCell.isOn = false
                UserDefaults.saveUD(turnOff, NOTIF_ALL)
            }
            
            cell.switchCell.addTarget(self, action: #selector(switchReceiveAll(switchState:)), for: .valueChanged)
        case 1:
            switch indexPath.row {
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_phamarcy"))
                cell.lblTime.labelStyle()
                
                if(dataResult.object(forKey: "is_received_shop") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_PHARMACY)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_PHARMACY)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceivePharmacy(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_tricare"))
                cell.lblTime.labelStyle()
                
                if(dataResult.object(forKey: "is_received_operator") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_TRICARE)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_TRICARE)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveTricare(switchState:)), for: .valueChanged)
            default:
                break
            }
        case 2:
            switch (indexPath.row){
            case 0:
                cell.lblTitle.labelStyle(title: Localizable(value: "weight"))
                cell.lblTime.labelStyle(title: dataResult.object(forKey: "weight_time") as? String)
                
                if(dataResult.object(forKey: "is_received_weight") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_WEIGHT)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_WEIGHT)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveWeight(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "breakfast"))
                cell.lblTime.labelStyle(title: dataResult.object(forKey: "breakfast_time") as? String)
                
                if(dataResult.object(forKey: "is_received_breakfast") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_BREAKFAST)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_BREAKFAST)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveBreakfast(switchState:)), for: .valueChanged)
            case 2:
                cell.lblTitle.labelStyle(title: Localizable(value: "lunch"))
                cell.lblTime.labelStyle(title: dataResult.object(forKey: "lunch_time") as? String)
                
                if(dataResult.object(forKey: "is_received_lunch") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_LUNCH)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_LUNCH)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveLunch(switchState:)), for: .valueChanged)
            case 3:
                cell.lblTitle.labelStyle(title: Localizable(value: "dinner"))
                cell.lblTime.labelStyle(title: dataResult.object(forKey: "dinner_time") as? String)
                
                if(dataResult.object(forKey: "is_received_dinner") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_DINNER)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_DINNER)
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveDinner(switchState:)), for: .valueChanged)
            case 4:
                cell.lblTitle.labelStyle(title: Localizable(value: "snack"))
                cell.lblTime.labelStyle(title: dataResult.object(forKey: "snack_time") as? String)
                
                if(dataResult.object(forKey: "is_received_snack") as? Int == 1){
                    cell.switchCell.isOn = true
                    UserDefaults.saveUD(turnOn, NOTIF_SNACK)
                }else{
                    cell.switchCell.isOn = false
                    UserDefaults.saveUD(turnOff, NOTIF_SNACK)
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
        switch (indexPath.row) {
        case 0:
            tableView.deselectRow(at: indexPath, animated: false)
        case 1:
            tableView.deselectRow(at: indexPath, animated: false)
        case 2:
            tableView.deselectRow(at: indexPath, animated: false)
        default:
            break
        }
    }
}
