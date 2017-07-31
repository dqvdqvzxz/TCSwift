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
    
    var dataGender = [Localizable(value: "male"), Localizable(value: "female")]
    var genderPicker = UIPickerView()
    
    var editMode = String()
    
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
            let url = URL(string: _obj.dicFacebookInfo[FB_AVATAR]!)
//            let placeholderImage = UIImage(named: "")!
            imgUser.af_setImage(withURL: url!, placeholderImage: nil)
        }else{
            //default image
        }

        //config mode
        if(editMode == MODE_MYPAGE){
            self.navigationItem.hidesBackButton = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: nil)
            contraintBottomScrollView.constant = 0
            btnNext.isHidden = true
        }else if(editMode == MODE_REGISTER){
            self.navigationItem.title = Localizable(value: "register_title")
            btnNext.buttonStyle(title: STRING_NEXT)
        }
        
        //add image to text field
        tfDateOfBirth.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        tfGender.addRightImage(#imageLiteral(resourceName: "ic_combobox"))
        
        //set default value of gender picker
        tfGender.text = dataGender[0]
        
        //make image circle
        //imgUser.makeCircle()
        
        // make border image
        imgUser.makeBorder(color: UIColor.lightGray)
        
        //date of birth
        showDatePicker()
        
        //gender
        showGenderPicker()
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
        let vc = TRCPharmacySearchViewController(nibName: "TRCPharmacySearchViewController", bundle: nil)
        vc.mode = MODE_REGISTER
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
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
        imgView = info[UIImagePickerControllerEditedImage] as! UIImage
        imgUser.contentMode = .scaleAspectFit
        imgUser.image = imgView
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
