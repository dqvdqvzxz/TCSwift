//
//  TRCAccountInfoInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import AlamofireImage

class TRCAccountInfoInputViewController: TRCBaseViewController {

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewGender: UIView!
    
    @IBOutlet weak var lblFirstName: UILabel!
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblFirstNameKata: UILabel!
    @IBOutlet weak var lblLastNameKata: UILabel!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    @IBOutlet weak var tfFirstNameKata: UITextField!
    @IBOutlet weak var tfLastNameKata: UITextField!
    @IBOutlet weak var tfDateOfBirth: UITextField!
    @IBOutlet weak var tfGender: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnUploadImage: UIButton!
    @IBOutlet weak var contraintBottomScrollView: NSLayoutConstraint!
    
    var pickerController = UIImagePickerController()
    var imgView = UIImage()
    
    let datePicker = UIDatePicker()
    
    var dataGender = [Localizable(value: "male"), Localizable(value: "female"), Localizable(value: "other")]
    var genderPicker = UIPickerView()
    
    var userName = String()
    var passWord = String()
    
    var mode = String()
    var isHasNewAvatar = false
    
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
        self.navigationItem.title = Localizable(value: "register_title")
        
        //UI of outlet
        lblFirstName.labelStyle(title: Localizable(value: "first_name"))
        lblLastName.labelStyle(title: Localizable(value: "last_name"))
        lblFirstNameKata.labelStyle(title: Localizable(value: "first_name_kata"))
        lblLastNameKata.labelStyle(title: Localizable(value: "last_name_kata"))
        lblDateOfBirth.labelStyle(title: Localizable(value: "birth_date"))
        lblGender.labelStyle(title: Localizable(value: "gender"))
        
        tfFirstName.textFieldStyle(placeHolder: "")
        tfLastName.textFieldStyle(placeHolder: "")
        tfFirstNameKata.textFieldStyle(placeHolder: "")
        tfLastNameKata.textFieldStyle(placeHolder: "")
        
        tfDateOfBirth.textFieldStyle(placeHolder: "")
        tfGender.textFieldStyle(placeHolder: "")
        
        //fill data if register with Facebook
        if(_obj.dicFacebookInfo[FB_FIRSTNAME] != nil){
            tfFirstName.text = _obj.dicFacebookInfo[FB_FIRSTNAME]
            tfFirstName.isUserInteractionEnabled = false
        }
        
        if(_obj.dicFacebookInfo[FB_MIDDLENAME] != nil || _obj.dicFacebookInfo[FB_LASTNAME] != nil){
            tfLastName.text = _obj.dicFacebookInfo[FB_MIDDLENAME]! + _obj.dicFacebookInfo[FB_LASTNAME]!
            tfLastName.isUserInteractionEnabled = false
        }
        
        if(_obj.dicFacebookInfo[FB_AVATAR] != nil){
            isHasNewAvatar = true
            let url = URL(string: _obj.dicFacebookInfo[FB_AVATAR]!)
//            let placeholderImage = UIImage(named: "")!
            imgUser.af_setImage(withURL: url!, placeholderImage: nil)
        }else{
            //default image
        }

        //config mode
        if(mode == MODE_REGISTER){
            self.navigationItem.title = Localizable(value: "register_title")
            btnNext.buttonStyle(title: STRING_NEXT)
        }else if(mode == MODE_MYPAGE){
            self.navigationItem.hidesBackButton = false
            btnNext.buttonStyle(title: "変更を保存")
        }
        
        
        //add image to text field
        tfDateOfBirth.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        tfGender.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        
        //set default value of gender picker
        tfGender.text = dataGender[0]
        
        //make image circle
        imgUser.makeBorder(color: UIColor.lightGray)
        imgUser.makeCircle()        
        // make border image
        
        //date of birth
        showDatePicker()
        
        //gender
        showGenderPicker()
        
        //get data
        getData()
    }
    
    //MARL: Config data
    func getData(){
        if(mode == MODE_MYPAGE){
            //fill data
            self.tfFirstName.text = _obj.objectAccountInfo.firstName
            self.tfLastName.text = _obj.objectAccountInfo.lastName
            self.tfFirstNameKata.text = _obj.objectAccountInfo.firstNameKata
            self.tfLastNameKata.text = _obj.objectAccountInfo.firstNameKata
            
            let dateData = _obj.objectAccountInfo.birthDay
            let stringDate = Global().dateFromString(string: dateData, format: "yyyy/MM/dd")
            let dateConvert = Global().stringFromDate(date: stringDate, format: "yyyy年MM月dd日")
            self.tfDateOfBirth.text = dateConvert
            
            let genderData = _obj.objectAccountInfo.sex
            switch (genderData){
            case "0":
                self.tfGender.text = Localizable(value: "male")
                self.genderPicker.selectRow(0, inComponent: 0, animated: true)
            case "1":
                self.tfGender.text = Localizable(value: "female")
                self.genderPicker.selectRow(1, inComponent: 0, animated: true)
            case "2":
                self.tfGender.text = Localizable(value: "other")
                self.genderPicker.selectRow(2, inComponent: 0, animated: true)
            default:
                break
            }
        }
    }
    
    //MARK: Gender picker
    func showGenderPicker(){
        genderPicker.dataSource = self
        genderPicker.delegate = self
        
        //toolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(doneGenderPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfGender.inputAccessoryView = toolbar
        
        // add datepicker to textField
        tfGender.inputView = genderPicker
    }
    
    func doneGenderPicker(){
        self.view.endEditing(true)
    }
    
    //MARK: Date picker of text field DateOfBirth
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: STRING_DONE, style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: STRING_CANCEL, style: .plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        // add toolbar to textField
        tfDateOfBirth.inputAccessoryView = toolbar
        // add datepicker to textField
        tfDateOfBirth.inputView = datePicker
        
    }
    
    func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日"
        tfDateOfBirth.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    //MARK: Take photo
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            pickerController.delegate = self
            pickerController.modalPresentationStyle = .currentContext
            pickerController.sourceType = .camera
            pickerController.allowsEditing = true
            self.present(self.pickerController, animated: true, completion: nil)
            pickerController.view.layoutIfNeeded()
        }else{
            Alert2(title: STRING_WARNING, message: Localizable(value: "camera_warning"))
        }
    }
    
    func openGallery(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            pickerController.allowsEditing = true
            self.present(self.pickerController, animated: true, completion: nil)
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnNext(_ sender: Any) {
        if (DEBUG_REMOVE_API) {
            doRegister()
            return
        }

        validate()
    }
    
    @IBAction func tapBtnUploadImage(_ sender: Any) {
        //create the AlertController
        let actionSheetController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        //create Cancel action
        let cancelAction = UIAlertAction(title: STRING_CANCEL, style: .cancel) { action -> Void in
            //dismiss action sheet
        }
        //take picture in camera
        let takePhotoCamera = UIAlertAction(title: STRING_TAKE_PHOTO_CAMERA, style: .default) { action -> Void in
            self.openCamera()
        }
        //take picture from gallery
        let takePhotoGallery = UIAlertAction(title: STRING_TAKE_PHOTO_GALLERY, style: .default) { action -> Void in
            self.openGallery()
        }
        
        //add action to sheet
        actionSheetController.addAction(cancelAction)
        actionSheetController.addAction(takePhotoCamera)
        actionSheetController.addAction(takePhotoGallery)
        
        //provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: Action
    func validate() {
        if (tfFirstName.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_first_name"))
            return
        }
        
        if (tfLastName.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_last_name"))
            return
        }
        
        if (tfFirstNameKata.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_first_name_kana"))
            return
        }
        
        if (tfLastNameKata.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_last_name_kana"))
            return
        }
        
        if (isHasNewAvatar) {
            uploadAvatar()
        } else {
            doRegister()
        }
    }
    
    func uploadAvatar() {
        guard let avatar = imgUser.image else {
            return
        }
        self.showHUD()
        TRCAccountInfoRequest().uploadAvatar(avatar, completion: { (resultString) in
            if (resultString == RESULT_SUCCESS) {
                self.doRegister()
            }
        }) { (error) in
            self.showAlert(error)
            self.doRegister()
        }
    }
    
    func doRegister() {
        // ** DEBUG NO API ** //
        if (DEBUG_REMOVE_API) {
            let vc = TRCPharmacySearchViewController(nibName: "TRCPharmacySearchViewController", bundle: nil)
            vc.mode = MODE_REGISTER
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            self.navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
            
            return
        }
        // ** ** ** //
        if (!isHasNewAvatar) {
            self.showHUD()
        }

        if(mode == MODE_REGISTER){
            var genderResult = ""
            var birthdayResult = ""
            var registerType = ""
            
            if(tfGender.text! == Localizable(value: "male")){
                genderResult = GENDER_MALE
            }else{
                genderResult = GENDER_FEMALE
            }
            
            if(UserDefaults.getUD(FB_TOKEN) != nil){
                registerType = REGISTER_TYPE_FACEBOOK
            }else{
                registerType = REGISTER_TYPE_NORMAL
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            birthdayResult = formatter.string(from: datePicker.date)
            
            TRCRegisterRequest().register(userName, passWord, tfFirstName.text!, tfLastName.text!, tfFirstNameKata.text!, tfLastNameKata.text!, genderResult, birthdayResult, registerType, completion: { (data) in
                self.hideHUD()
            
                //save access token
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                if (Global().isNotNull(dataResult.object(forKey: ACCESS_TOKEN))) {
                    UserDefaults.saveUD(dataResult.object(forKey: ACCESS_TOKEN), ACCESS_TOKEN)
                }
                
                let vc = TRCPharmacySearchViewController(nibName: "TRCPharmacySearchViewController", bundle: nil)
                vc.mode = MODE_REGISTER
                let backItem = UIBarButtonItem()
                backItem.title = STRING_BACK
                self.navigationItem.backBarButtonItem = backItem
                self.navigationController?.pushViewController(vc, animated: true)
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }else if(mode == MODE_MYPAGE){
            var genderResult = ""
            var birthdayResult = ""
            
            if(tfGender.text! == Localizable(value: "male")){
                genderResult = GENDER_MALE
            }else{
                genderResult = GENDER_FEMALE
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            birthdayResult = formatter.string(from: datePicker.date)
            
            TRCAccountInfoRequest().accountInfoChange(tfFirstName.text!, tfLastName.text!, tfFirstNameKata.text!, tfLastNameKata.text!, birthdayResult, genderResult, completion: { (data) in
                self.hideHUD()
                
                let alert = UIAlertController(title: nil,
                                              message: Localizable(value: "profile_updated"),
                                              preferredStyle: .alert)
                // add the action
                alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                              style: UIAlertActionStyle.default,
                                              handler: { action in
                                                let viewControllers: [UIViewController] = _obj.nc5.viewControllers
                                                for descView in viewControllers {
                                                    if(descView is TRCMyPageViewController){
                                                        _obj.nc5.popToViewController(descView, animated: true)
                                                    }
                                                }
                }))
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }
    }
}

extension TRCAccountInfoInputViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataGender.count
    }
}

extension TRCAccountInfoInputViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tfGender.text = dataGender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataGender[row]
    }
}

extension TRCAccountInfoInputViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        isHasNewAvatar = true
        imgView = info[UIImagePickerControllerEditedImage] as! UIImage
        imgUser.contentMode = .scaleAspectFit
        imgUser.image = imgView
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension TRCAccountInfoInputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 255 // Bool
    }
}
