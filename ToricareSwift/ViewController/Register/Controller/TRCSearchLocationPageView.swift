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
    
    var dataAddress: [TRCPrefecture] = []
    var dataSubAddress: [TRCCity] = []
    
    var addressId = ""
    var subAddressIndex = ""
    
    var delegate:TRCSearchLocationPageViewDelegate?

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        loadPrefectures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addFirstDataAddress() {
        let firstObject = TRCPrefecture(name: Localizable(value: "all"), prefecture: NSNumber.init(value: -1))
        self.dataAddress.insert(firstObject, at: 0)
        self.tfAddress.text = firstObject.name
    }
    
    func addFirstDataSubAddress() {
        let firstObject = TRCCity(name: Localizable(value: "all"), cityId: NSNumber.init(value: -1), cityCode: "")
        self.dataSubAddress.insert(firstObject, at: 0)
        self.tfSubAddress.text = firstObject.name
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
            guard let data = data else { return }
            guard let prefectureArray = data.object(forKey: DATA) else { return }
            do {
                self.dataAddress = try parseArray(prefectureArray as! [JSONObject])
            }
            catch
            {
                print("JSONParsin Error: \(error)")
            }
            // Add first value ALL
            self.addFirstDataAddress()
            self.addressPicker.reloadAllComponents()
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func getCity() {
        self.showHUD()

        TRCPrefecturesRequest().getCity(addressId, completion: { (data) in
            self.hideHUD()
            
            guard let data = data else { return }
            guard let dataSubAddressArray = data.object(forKey: DATA) else { return }
            do {
                self.dataSubAddress = try parseArray(dataSubAddressArray as! [JSONObject])
            }
            catch
            {
                print("JSONParsin Error: \(error)")
            }
            self.addFirstDataSubAddress()
            self.subAddressPicker.reloadAllComponents()
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
        if (pickerView.tag == 1) {
            let dataPrefecture = dataAddress[row]
            return dataPrefecture.name
        } else {
            let dataCity = dataSubAddress[row]
            return dataCity.name
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerView.tag == 1){
            let dataPrefecture = dataAddress[row]
            
            tfAddress.text = dataPrefecture.name
            addressId = dataPrefecture.prefectureId.stringValue
        }else{
            let dataCity = dataSubAddress[row]

            tfSubAddress.text = dataCity.name
            subAddressIndex = dataCity.cityId.stringValue
        }
    }
}
