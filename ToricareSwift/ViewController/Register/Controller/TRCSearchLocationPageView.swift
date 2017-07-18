//
//  TRCSearchLocationPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSearchLocationPageView: TRCBaseViewController {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSubAddress: UILabel!
    
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfSubAddress: UITextField!
    
    var addressPicker = UIPickerView()
    var subAddressPicker = UIPickerView()
    
    var dataAddress = ["1", "2"]
    var dataSubAddress = ["2", "3", "4"]
    
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
        //UI of outlet
        lblAddress.labelStyle(title: "")
        lblSubAddress.labelStyle(title: "")
        
        tfAddress.textFieldStyle(placeHolder: "")
        tfSubAddress.textFieldStyle(placeHolder: "")
        
        tfAddress.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        tfSubAddress.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        
        //picker
        addressPicker.tag = 1
        
        tfAddress.text = dataAddress[0]
        tfSubAddress.text = dataSubAddress[0]
        
        showAddressPicker()
        
        showSubAddressPicker()
    }
    
    //MARK: Address Picker
    func showAddressPicker(){
        addressPicker.dataSource = self
        addressPicker.delegate = self
        
        //toolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfAddress.inputAccessoryView = toolbar
        // add datepicker to textField
        tfAddress.inputView = addressPicker
    }
    
    func showSubAddressPicker(){
        subAddressPicker.dataSource = self
        subAddressPicker.delegate = self
        
        //toolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfSubAddress.inputAccessoryView = toolbar
        // add datepicker to textField
        tfSubAddress.inputView = subAddressPicker
    }
    
    //MARK: Action
    func donePicker(){
        self.view.endEditing(true)
    }
}

extension TRCSearchLocationPageView: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return dataAddress.count
        }else{
            return dataSubAddress.count
        }
    }
}

extension TRCSearchLocationPageView: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return dataAddress[row]
        }else{
            return dataSubAddress[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            tfAddress.text = dataAddress[row]
        }else{
            tfSubAddress.text = dataSubAddress[row]
        }
    }
}
