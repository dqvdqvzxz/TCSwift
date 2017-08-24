//
//  TRCWalkingGoalDetailViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/12/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCWalkingGoalDetailViewController: TRCBaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSteps: UILabel!
    
    @IBOutlet weak var pickerTarget: UIPickerView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var pickerData = Array<Int>()
    
    var goalInfo: TRCGoal!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        initValuePicker()
        
//        getData()
        
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(_obj.newStep != ""){
            self.pickerTarget.selectRow(((Int(_obj.newStep)! / 1000) - 1), inComponent: 0, animated: true)
        }
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "setting_target")
        
        //UI of outlet
        lblTitle.labelStyle(title: Localizable(value: "walking_per_day"))
        lblSteps.labelStyle(title: Localizable(value: "walking"))
        
        btnSave.buttonStyle(title: Localizable(value: "save_change"))
        
        pickerTarget.dataSource = self
        pickerTarget.delegate = self
        
        if(_obj.objectGoal != nil){
            self.pickerTarget.selectRow(((Int(_obj.objectGoal.steps)! / 1000) - 1) , inComponent: 0, animated: true)
        }
    }
    
    //MARK: Get data
    func getData(){
        if(_obj.objectGoal == nil){
            self.showHUD()
            TRCGoalRequest().goalInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                self.hideHUD()
                do {
                    self.goalInfo = try parseDict(dataResult as! JSONObject) as TRCGoal
                    _obj.objectGoal = self.goalInfo
                    
                    for i in stride(from: 1000, to: 51000, by: 1000){
                        if(i == Int(_obj.objectGoal.steps)){
                            self.pickerTarget.selectRow(((i / 1000) - 1) , inComponent: 0, animated: true)
                        }
                    }
                } catch {
                    print("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }else{
            self.pickerTarget.selectRow(7, inComponent: 0, animated: true)
        }
    }
    
    //MARK: Function
    func initValuePicker(){
        for i in stride(from: 1000, to: 51000, by: 1000){
            pickerData.append(i)
        }
    }

    //MARK: Button Action
    @IBAction func tapBtnSave(_ sender: Any) {
        _obj.newStep = Global().convertObjectToString((pickerTarget.selectedRow(inComponent: 0) + 1) * 1000)
        self.showHUD()
        TRCGoalRequest().goalStepsChange(_obj.newStep, completion: {(data) in
            self.hideHUD()
            
            _obj.objectGoal.steps = _obj.newStep
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for descView in viewControllers {
                if(descView is TRCMyPageViewController){
                    _obj.nc5.popToViewController(descView, animated: true)
                }
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
    }
}

extension TRCWalkingGoalDetailViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}

extension TRCWalkingGoalDetailViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        lblTitle.text = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 60)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = pickerData[row].description
            pickerLabel?.textColor = UIColor.init(hexString: MAIN_COLOR)
            
            return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 90
    }
    
    
//    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
////        return 190
//    }
}
