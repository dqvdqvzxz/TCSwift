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
    func pushLocationToSearchResult(_ mode: String)
}

class TRCSearchLocationPageView: TRCBaseViewController {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblSubAddress: UILabel!
    
    @IBOutlet weak var tfAddress: CustomizeTextField!
    @IBOutlet weak var tfSubAddress: CustomizeTextField!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var addressPicker = UIPickerView()
    var subAddressPicker = UIPickerView()
    
    var dataAddress: [TRCPrefecture] = []
    var dataSubAddress: [TRCCity] = []
    
    var prefectureId = ""
    var cityId = ""
    
    var delegate:TRCSearchLocationPageViewDelegate?

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        loadPrefectures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configFirstDataAddress() {
        let dataPrefecture = dataAddress[0]
        tfAddress.text = dataPrefecture.name
        prefectureId = dataPrefecture.prefectureId
        UserDefaults.saveUD(prefectureId, SEARCH_PREFECTURE)
        UserDefaults.saveUD(dataPrefecture.name, SEARCH_PREFECTURE_NAME)
    }
    
    func configFirstDataSubAddress() {
        let dataCity = dataSubAddress[0]
        tfSubAddress.text = dataCity.name
        cityId = dataCity.cityId
        UserDefaults.saveUD(cityId, SEARCH_TOWN)
        UserDefaults.saveUD(dataCity.name, SEARCH_TOWN_NAME)
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
        
        btnSearch.buttonStyle(title: STRING_SEARCH)

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
        toolbar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        
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
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        tfSubAddress.inputAccessoryView = toolbar
        // add datepicker to textField
        tfSubAddress.inputView = subAddressPicker
    }
    
    //MARK: Action
    func donePickerAddress() {
//        if (prefectureId.isBlank) {
//            cityId = ""
//            tfSubAddress.text = ""
//            self.view.endEditing(true)
//
//            return
//        }
//
//        getCity()
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
                DLog("JSONParsin Error: \(error)")
            }
            // Add first value ALL
            self.addressPicker.reloadAllComponents()
            self.configFirstDataAddress()
            self.getCity()
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    func getCity() {
        self.showHUD()

        TRCPrefecturesRequest().getCity(prefectureId, completion: { (data) in
            self.hideHUD()
            
            guard let data = data else { return }
            guard let dataSubAddressArray = data.object(forKey: DATA) else { return }
            do {
                self.dataSubAddress = try parseArray(dataSubAddressArray as! [JSONObject])
            }
            catch
            {
                DLog("JSONParsin Error: \(error)")
            }
            self.subAddressPicker.reloadAllComponents()
            self.configFirstDataSubAddress()
        }, failed: { (error) in
            self.hideHUD()
            self.showAlert(error)
        })
    }
    
    //MARK: Button action
    @IBAction func tapBtnSearch(_ sender: Any) {
        //data search
        UserDefaults.removeUD(SEARCH_LAT)
        UserDefaults.removeUD(SEARCH_LON)
        UserDefaults.removeUD(SEARCH_KEYWORD)
        
        UserDefaults.saveUD(prefectureId, SEARCH_PREFECTURE)
        UserDefaults.saveUD(self.tfAddress.text!, SEARCH_PREFECTURE_NAME)
        UserDefaults.saveUD(cityId, SEARCH_TOWN)
        UserDefaults.saveUD(self.tfSubAddress.text!, SEARCH_TOWN_NAME)

        if(_obj.mode == MODE_MYPAGE){
            if (delegate != nil) {
                delegate?.pushLocationToSearchResult(MODE_MYPAGE)
                return
            }
        }else if(_obj.mode == MODE_REGISTER){
            if (delegate != nil) {
                delegate?.pushLocationToSearchResult(MODE_REGISTER)
                return
            }
        }
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
            prefectureId = dataPrefecture.prefectureId
            getCity()
        }else{
            let dataCity = dataSubAddress[row]
            tfSubAddress.text = dataCity.name
            cityId = dataCity.cityId
        }
    }
}
