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
    
    var turnOn: String = NOTIF_TURNON
    var turnOff: String = NOTIF_TURNOFF
    
    var section = 3
    
    var dataResult = NSMutableDictionary()
    
    var dataHours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    
    var dataMinutes = ["00", "30"]
    
    var cellChange: Int!
    
    var timePicker = UIPickerView()
    
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
        TRCNotificationRequest().notificationInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            self.hideHUD()
            
            //set result to dic
            self.dataResult = NSMutableDictionary(dictionary: dataResult)  //dataResult as! NSMutableDictionary
            
            if(dataResult.object(forKey: NOTIF_PARAM_PUSHED) as? Int == 1){
                UserDefaults.saveUD(self.turnOn, NOTIF_ALL)
            }else{
                UserDefaults.saveUD(self.turnOff, NOTIF_ALL)
            }

            
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
        TRCNotificationRequest().notificationInfoChange(UserDefaults.getUD(NOTIF_ALL) as! String, UserDefaults.getUD(NOTIF_PHARMACY) as! String, UserDefaults.getUD(NOTIF_TRICARE) as! String, UserDefaults.getUD(NOTIF_WEIGHT) as! String, UserDefaults.getUD(NOTIF_BREAKFAST) as! String, UserDefaults.getUD(NOTIF_LUNCH) as! String, UserDefaults.getUD(NOTIF_DINNER) as! String, isReceivedSnack: UserDefaults.getUD(NOTIF_SNACK) as! String, self.dataResult[NOTIF_PARAM_TIME_WEIGHT] as! String, self.dataResult[NOTIF_PARAM_TIME_BREAKFAST] as! String, self.dataResult[NOTIF_PARAM_TIME_LUNCH] as! String, self.dataResult[NOTIF_PARAM_TIME_DINNER] as! String, self.dataResult[NOTIF_PARAM_TIME_SNACK] as! String, completion: {(data) in
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
            
            if(Global().convertObjectToString(UserDefaults.getUD(NOTIF_ALL)) == turnOn){
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
                cell.lblTime.labelStyle(title: dataResult.object(forKey: NOTIF_PARAM_TIME_WEIGHT) as? String)
                
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
                cell.lblTime.labelStyle(title: dataResult.object(forKey: NOTIF_PARAM_TIME_BREAKFAST) as? String)
                
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
                cell.lblTime.labelStyle(title: dataResult.object(forKey: NOTIF_PARAM_TIME_LUNCH) as? String)
                
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
                cell.lblTime.labelStyle(title: dataResult.object(forKey: NOTIF_PARAM_TIME_DINNER) as? String)
                
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
                cell.lblTime.labelStyle(title: dataResult.object(forKey: NOTIF_PARAM_TIME_SNACK) as? String)
                
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
    
    func doneGenderPicker(){
        //get time
        let hourPicked =  timePicker.selectedRow(inComponent: 0)
        let minutePicked = timePicker.selectedRow(inComponent: 1)
        let hourResult = dataHours[hourPicked]
        let minuteResult = dataMinutes[minutePicked]
        let timeResult = "\(hourResult):\(minuteResult)"
        
        //set time to dataResult
        switch (self.cellChange){
        case 0:
            self.dataResult[NOTIF_PARAM_TIME_WEIGHT] = timeResult
        case 1:
            self.dataResult[NOTIF_PARAM_TIME_BREAKFAST] = timeResult
        case 2:
            self.dataResult[NOTIF_PARAM_TIME_LUNCH] = timeResult
        case 3:
            self.dataResult[NOTIF_PARAM_TIME_DINNER] = timeResult
        case 4:
            self.dataResult[NOTIF_PARAM_TIME_SNACK] = timeResult
        default:
            break
        }
        
        //reload cell
        let indexPath = IndexPath(item: self.cellChange, section: 2)
        self.tblNotify.reloadRows(at: [indexPath], with: .automatic)
        
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! TRCLinkedServiceCell

        self.timePicker.dataSource = self
        self.timePicker.delegate = self
        
        switch (indexPath.section) {
        case 0:
            break
        case 1:
            break
        case 2:
            //toolBar
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            
            //done button & cancel button
            let spaceButton1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            var title = UIBarButtonItem()
            switch (indexPath.row) {
            case 0:
                title = UIBarButtonItem(title: Localizable(value: "weight"), style: .plain, target: self, action: nil)
            case 1:
                title = UIBarButtonItem(title: Localizable(value: "breakfast"), style: .plain, target: self, action: nil)
            case 2:
                title = UIBarButtonItem(title: Localizable(value: "lunch"), style: .plain, target: self, action: nil)
            case 3:
                title = UIBarButtonItem(title: Localizable(value: "dinner"), style: .plain, target: self, action: nil)
            case 4:
                title = UIBarButtonItem(title: Localizable(value: "snack"), style: .plain, target: self, action: nil)
            default:
                break
            }
            let spaceButton2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(doneGenderPicker))
            toolbar.setItems([spaceButton1,title,spaceButton2,doneButton], animated: false)
            
            // add toolbar to textField
            currentCell.tfTime.inputAccessoryView = toolbar
            
            // add datepicker to textField
            currentCell.tfTime.inputView = timePicker
            
            self.cellChange = indexPath.row
            
            currentCell.tfTime.becomeFirstResponder()
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
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
