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

    let pickerData = ["1000", "2000", "3000", "4000", "5000", "6000", "7000", "8000", "9000", "10000"]
    
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
        self.navigationItem.title = Localizable(value: "setting_target")
        
        //UI of outlet
        lblTitle.labelStyle(title: Localizable(value: "walking_per_day"))
        lblSteps.labelStyle(title: Localizable(value: "walking"))
        
        btnSave.buttonStyle(title: nil)
        
        pickerTarget.dataSource = self
        pickerTarget.delegate = self
        
        pickerTarget.selectRow(7, inComponent: 0, animated: true)
    }

    //MARK: Button Action
    @IBAction func tapBtnSave(_ sender: Any) {
        
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
        lblTitle.text = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 60)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = pickerData[row]
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
