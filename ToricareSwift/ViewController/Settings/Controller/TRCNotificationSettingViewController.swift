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
    
    var section = 3
    
    var dataResult = NSMutableDictionary()
    
    var dataHours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    
    var dataMinutes = ["00", "30"]
    
    var cellChange: Int!
    
    var timePicker = UIPickerView()
    
    var notificationInfo : TRCNotification!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        hideItem(isHide: true)
        getData()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideItem(isHide: Bool) {
        tblNotify.isHidden = isHide
        btnSave.isHidden = isHide
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_SETTING_NOTIFY
        
        btnSave.buttonStyle(title: Localizable(value: "notification_button_change"))
        
        //table view
        tblNotify.dataSource = self
        tblNotify.delegate = self
        tblNotify.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblNotify.tableFooterView = UIView()
        hideItem(isHide: false)
    }
    
    //MARK: Get data
    func getData(){
        self.showHUD()
        TRCNotificationRequest().notificationInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            do {
                self.notificationInfo = try parseDict(dataResult as! JSONObject) as TRCNotification
                self.hideHUD()
                self.configUI()
                
                DLog(self.notificationInfo)
            } catch {
                DLog("JSONParsin Error: \(error)")
            } 
        }) { (error) in
            self.hideHUD()
            ELog(error)
            self.showAlert(error)
        }
    }
    
    //MARK: Button action
    @IBAction func tapBtnSave(_ sender: Any) {
        self.showHUD()
        TRCNotificationRequest().notificationInfoChange(self.notificationInfo.isPush, self.notificationInfo.isReceivedShop, self.notificationInfo.isReceivedOperator, self.notificationInfo.isReceivedWeight, self.notificationInfo.isReceivedBreakfast, self.notificationInfo.isReceivedLunch, self.notificationInfo.isReceivedDinner, self.notificationInfo.isReceivedSnack, self.notificationInfo.timeWeight, self.notificationInfo.timeBreakfast, self.notificationInfo.timeLunch, self.notificationInfo.timeDinner, self.notificationInfo.timeSnack, completion: {(data) in
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
            self.notificationInfo.isPush = NOTIF_TURNON
            section = 3
        }else{
            self.notificationInfo.isPush = NOTIF_TURNOFF
            section = 1
        }
        tblNotify.reloadData()
    }
    
    func switchReceivePharmacy(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedShop = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedShop = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveTricare(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedOperator = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedOperator = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveWeight(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedWeight = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedWeight = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveBreakfast(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedBreakfast = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedBreakfast = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveLunch(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedLunch = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedLunch = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveDinner(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedDinner = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedDinner = NOTIF_TURNOFF
        }
    }
    
    func switchReceiveSnack(switchState: UISwitch){
        if(switchState.isOn){
            self.notificationInfo.isReceivedSnack = NOTIF_TURNON
        }else{
            self.notificationInfo.isReceivedSnack = NOTIF_TURNOFF
        }
    }
}

extension TRCNotificationSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if(self.notificationInfo.isPush == NOTIF_TURNON){
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
            
            if(self.notificationInfo.isPush == NOTIF_TURNON){
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
                
                if(self.notificationInfo.isReceivedShop == NOTIF_TURNON){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceivePharmacy(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "notify_from_tricare"))
                cell.lblTime.labelStyle()
                
                if(self.notificationInfo.isReceivedOperator == NOTIF_TURNON){
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
                cell.lblTime.labelStyle(title: self.notificationInfo.timeWeight)
                
                if(self.notificationInfo.isReceivedWeight == NOTIF_TURNON){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveWeight(switchState:)), for: .valueChanged)
            case 1:
                cell.lblTitle.labelStyle(title: Localizable(value: "breakfast"))
                cell.lblTime.labelStyle(title: self.notificationInfo.timeBreakfast)
                
                if(self.notificationInfo.isReceivedBreakfast == NOTIF_TURNON){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveBreakfast(switchState:)), for: .valueChanged)
            case 2:
                cell.lblTitle.labelStyle(title: Localizable(value: "lunch"))
                cell.lblTime.labelStyle(title: self.notificationInfo.timeLunch)
                
                if(self.notificationInfo.isReceivedLunch == NOTIF_TURNON){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveLunch(switchState:)), for: .valueChanged)
            case 3:
                cell.lblTitle.labelStyle(title: Localizable(value: "dinner"))
                cell.lblTime.labelStyle(title: self.notificationInfo.timeDinner)
                
                if(self.notificationInfo.isReceivedDinner == NOTIF_TURNON){
                    cell.switchCell.isOn = true
                }else{
                    cell.switchCell.isOn = false
                }
                
                cell.switchCell.addTarget(self, action: #selector(switchReceiveDinner(switchState:)), for: .valueChanged)
            case 4:
                cell.lblTitle.labelStyle(title: Localizable(value: "snack"))
                cell.lblTime.labelStyle(title: self.notificationInfo.timeSnack)
                
                if(self.notificationInfo.isReceivedSnack == NOTIF_TURNON){
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
            self.notificationInfo.timeWeight = timeResult
        case 1:
            self.notificationInfo.timeBreakfast = timeResult
        case 2:
            self.notificationInfo.timeLunch = timeResult
        case 3:
            self.notificationInfo.timeDinner = timeResult
        case 4:
            self.notificationInfo.timeSnack = timeResult
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
    
        timePicker.selectRow(15, inComponent: 0, animated: true)
        
        let timeResult = currentCell.lblTime.text!
        let timeSeparated = timeResult.components(separatedBy: ":")
        let time1: String = timeSeparated[0]
        let time2: String = timeSeparated[1]
        timePicker.selectRow(Int(time1)!, inComponent: 0, animated: true)
        timePicker.selectRow((Int(time2)! / 30), inComponent: 1, animated: true)
        
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
