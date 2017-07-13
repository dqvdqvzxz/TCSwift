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
        self.navigationItem.title = ""
        
        //UI of outlet
        lblTitle.labelStyle(title: nil, fontSize: LABEL_FONT_SIZE, textColor: LABEL_FONT_COLOR)
        
        btnSave.buttonStyle(title: nil, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        
        pickerTarget.dataSource = self
        pickerTarget.delegate = self
    }

    //MARK: Button Action
    @IBAction func tapBtnSave(_ sender: Any) {
        
    }
}

extension TRCWalkingGoalDetailViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(component == 0){
            return pickerData.count
        }else{
            return 1
        }
    }
}

extension TRCWalkingGoalDetailViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblTitle.text = pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if(component == 0){
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 60)
                pickerLabel?.textAlignment = .center
            }
            pickerLabel?.text = pickerData[row]
            pickerLabel?.textColor = UIColor.init(hexString: MAIN_COLOR)
            
            return pickerLabel!
        }else{
            var pickerLabel: UILabel? = (view as? UILabel)
            if pickerLabel == nil {
                pickerLabel = UILabel()
                pickerLabel?.font = UIFont.systemFont(ofSize: 12)
                pickerLabel?.textAlignment = .left
            }
            pickerLabel?.text = "Steps"

            return pickerLabel!
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        if(component == 0){
            return 90
        }else{
            return 30
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if(component == 0){
            return 170
        }else{
            return 50
        }
    }
}
