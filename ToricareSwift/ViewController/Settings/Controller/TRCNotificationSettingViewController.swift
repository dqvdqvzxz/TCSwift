//
//  TRCNotificationSettingViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationSettingViewController: TRCBaseViewController {

    @IBOutlet var viewTimePicker: UIView!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var viewToolbar: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var timePicker: UIPickerView!
    
    @IBOutlet weak var tblNotify: UITableView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var turnOn: String = NOTIF_TURNON
    var turnOff: String = NOTIF_TURNOFF
    
    var section = 3
    
    var dataResult = NSDictionary()
    
    var dataHours = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    var dataMinutes = ["0", "30"]
    
    var genderPicker = UIPickerView()
    
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
        
        //UI of time picker view
        viewTimePicker.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
        viewToolbar.backgroundColor = UIColor.init(hexString: "ffffff", alpha: 0.7)
        timePicker.backgroundColor = UIColor.init(hexString: "ffffff", alpha: 0.6)

        
        //table view
        tblNotify.dataSource = self
        tblNotify.delegate = self
        tblNotify.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblNotify.tableFooterView = UIView()
    }
    
    //MARK: Get data
    func getData(){
        self.showHUD()
        TRCNotificationRequest().notificationInfo(completion: {(data) in
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
        self.showHUD()
        TRCNotificationRequest().notificationInfoChange(UserDefaults.getUD(NOTIF_ALL) as! String, UserDefaults.getUD(NOTIF_PHARMACY) as! String, UserDefaults.getUD(NOTIF_TRICARE) as! String, UserDefaults.getUD(NOTIF_WEIGHT) as! String, UserDefaults.getUD(NOTIF_BREAKFAST) as! String, UserDefaults.getUD(NOTIF_LUNCH) as! String, UserDefaults.getUD(NOTIF_DINNER) as! String, isReceivedSnack: UserDefaults.getUD(NOTIF_SNACK) as! String, "10:00", "10:00", "10:00", "10:00", "10:00", completion: {(data) in
            self.hideHUD()
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for descView in viewControllers {
                if(descView is TRCSettingViewController){
                    _obj.nc5.popToViewController(descView, animated: true)
                }
            }
            
            self.configUI()
            
        }) { (error) in
            self.hideHUD()
            ELog(error)
            self.showAlert(error)
        }
    }
    
    @IBAction func tapBtnDone(_ sender: Any) {
        viewTimePicker.removeFromSuperview()
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
        if(dataResult.object(forKey: NOTIF_PARAM_PUSHED) as? Int == 1){
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
            
            if(dataResult.object(forKey: NOTIF_PARAM_PUSHED) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_SHOP) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_OPERATOR) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_WEIGHT) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_BREAKFAST) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_LUNCH) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_DINNER) as? Int == 1){
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
                
                if(dataResult.object(forKey: NOTIF_PARAM_SNACK) as? Int == 1){
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
        let currentCell = tableView.cellForRow(at: indexPath) as! TRCLinkedServiceCell

        self.timePicker.dataSource = self
        self.timePicker.delegate = self
        
        viewTimePicker.frame = self.view.bounds
        viewTimePicker.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        self.view.addSubview(viewTimePicker)
        
        let hourResult =  timePicker.selectedRow(inComponent: 0)
        let minuteResult = (timePicker.selectedRow(inComponent: 1) * 30)
        
        print(hourResult, minuteResult)
        currentCell.lblTime.text = "\(hourResult) : \(minuteResult)"
    }
}

extension TRCNotificationSettingViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return dataHours.count
        }else if(component == 1){
            return dataMinutes.count
        }
        return 0
    }
}

extension TRCNotificationSettingViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0){
            return dataHours[row]
        }else if(component == 1){
            return dataMinutes[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 60
    }
}
