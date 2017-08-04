//
//  TRCSearchLocationPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

protocol TRCSearchLocationPageViewDelegate: class {
    func openLoading()
    func closeLoading()
}

class TRCSearchLocationPageView: TRCBaseViewController {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSubAddress: UILabel!
    
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfSubAddress: UITextField!
    
    var addressPicker = UIPickerView()
    var subAddressPicker = UIPickerView()
    
    var dataAddress = NSMutableArray()
    var dataSubAddress = NSMutableArray()
    
    var addressId = ""
    var subAddressIndex = ""
    
    var delegate:TRCSearchLocationPageViewDelegate?

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        loadPrefectures()
        initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() {
        let firstObject = TRCPrefecturesObject()
        firstObject.name = Localizable(value: "all")
        self.dataAddress.insert(firstObject, at: 0)

        let firstObjectSub = TRCCityObject()
        firstObjectSub.name = Localizable(value: "all")
        self.dataSubAddress.insert(firstObjectSub, at: 0)
    }
    
    //MARK: Config UI
    func configUI(){
        //UI of outlet
        lblAddress.labelStyle(title: Localizable(value: "prefecture"))
        lblSubAddress.labelStyle(title: Localizable(value: "town"))
        
        tfAddress.textFieldStyle(placeHolder: "")
        tfSubAddress.textFieldStyle(placeHolder: "")
        
        tfAddress.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        tfSubAddress.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        //picker
        addressPicker.tag = 1
        
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
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(donePickerAddress))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfAddress.inputAccessoryView = toolbar
        // add datepicker to textField
        tfAddress.inputView = addressPicker
//        addressPicker.showsSelectionIndicator = true
    }
    
    func showSubAddressPicker(){
        subAddressPicker.dataSource = self
        subAddressPicker.delegate = self
        
        //toolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(donePickerSubAddress))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfSubAddress.inputAccessoryView = toolbar
        // add datepicker to textField
        tfSubAddress.inputView = subAddressPicker
    }
    
    //MARK: Action
    func donePickerAddress() {
        getCity()
        self.view.endEditing(true)
    }
    
    func donePickerSubAddress() {
        self.view.endEditing(true)
    }
    
    func showHUD() {
        if (self.delegate != nil) {
            self.delegate?.openLoading()
        }
    }
    
    override func hideHUD() {
        if (self.delegate != nil) {
            self.delegate?.closeLoading()
        }
    }
    
    //MARK: API
    func loadPrefectures() {
        self.showHUD()
        TRCPrefecturesRequest().getPrefectures(completion: { (data) in
            self.hideHUD()

            let prefectureArray = data?.object(forKey: DATA)
            self.dataAddress = NSMutableArray(array: TRCPrefecturesObject().parse(prefectureArray as? Array<Any>))
            let firstObject = TRCPrefecturesObject()
            firstObject.name = Localizable(value: "all")
            self.dataAddress.insert(firstObject, at: 0)
            
            self.addressPicker.reloadAllComponents()
            self.addressId = (self.dataAddress.object(at: 0) as! TRCPrefecturesObject).prefectureId
            self.tfAddress.text = (self.dataAddress.object(at: 0) as! TRCPrefecturesObject).name
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func getCity() {
        self.showHUD()

        TRCPrefecturesRequest().getCity(addressId, completion: { (data) in
            self.hideHUD()
            let cityArray = data?.object(forKey: DATA)
            self.dataSubAddress = NSMutableArray(array: TRCCityObject().parse(cityArray as? Array<Any>))
            let firstObject = TRCCityObject()
            firstObject.name = Localizable(value: "all")
            self.dataSubAddress.insert(firstObject, at: 0)
            
            self.subAddressPicker.reloadAllComponents()
            self.subAddressIndex = (self.dataSubAddress.object(at: 0) as! TRCCityObject).cityId
            self.tfSubAddress.text = (self.dataSubAddress.object(at: 0) as! TRCCityObject).name
        }, failed: { (error) in
            self.hideHUD()
            self.showAlert(error)
        })
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
            return (dataAddress.object(at: row) as! TRCPrefecturesObject).name
        }else{
            return (dataSubAddress.object(at: row) as! TRCCityObject).name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            tfAddress.text = (dataAddress.object(at: row) as! TRCPrefecturesObject).name
            addressId = (dataAddress.object(at: row) as! TRCPrefecturesObject).prefectureId
        }else{
            tfSubAddress.text = (dataSubAddress.object(at: row) as! TRCCityObject).name
            subAddressIndex = (dataSubAddress.object(at: row) as! TRCCityObject).cityId
        }
    }
}
