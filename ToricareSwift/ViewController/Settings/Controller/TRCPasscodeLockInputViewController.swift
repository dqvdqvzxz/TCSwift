//
//  TRCPasscodeLockInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasscodeLockInputViewController: TRCBaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblError2: UILabel!

    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewImage1: UIView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var viewImage2: UIView!
    @IBOutlet weak var imgView2: UIImageView!
    
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewImage3: UIView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var viewImage4: UIView!
    @IBOutlet weak var imgView4: UIImageView!
    
    @IBOutlet weak var tfPasscode: UITextField!
    
    var mode = String()
    
    var modeChange = String()
    
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
        //UI
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewMain.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewLeft.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage1.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage2.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewRight.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage3.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage4.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)

        
        imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        
        tfPasscode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfPasscode.becomeFirstResponder()
        tfPasscode.isHidden = true
        
        lblError.isHidden = true
        lblError2.isHidden = true
        lblError.labelStyle(title: "", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: ERROR_COLOR)
        lblError2.labelStyle(title: "", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: ERROR_COLOR)
        
        configMode()
    }
    
    func configMode(){
        
        //customize close button
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: Localizable(value: "back_passcode"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(close(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        switch (mode) {
        case MODE_LOGIN:
            self.navigationItem.title = Localizable(value: "input_passcode_nav")
            
            lblTitle.labelStyle(title: Localizable(value: "input_passcode"))
        case MODE_SETUP:
            self.navigationItem.title = Localizable(value: "input_passcode_nav")

            if(modeChange == MODE_SETUP_NEW){
                lblTitle.labelStyle(title: Localizable(value: "input_new_passcode"))
                self.navigationItem.title = Localizable(value: "input_passcode_nav")
            }else{
                lblTitle.labelStyle(title: Localizable(value: "input_passcode"))
            }
        case MODE_CONFIRM:
            self.navigationItem.title = Localizable(value: "input_passcode_nav")

            lblTitle.labelStyle(title: Localizable(value: "confirm_passcode"))
        case MODE_CHANGE:
            self.navigationItem.title = Localizable(value: "input_passcode_nav")

            lblTitle.labelStyle(title: Localizable(value: "input_current_passcode"))
        case MODE_REMOVE:
            self.navigationItem.title = Localizable(value: "input_passcode_nav")

            lblTitle.labelStyle(title: Localizable(value: "input_passcode"))
        default:
            break
        }
    }
    
    func close(sender: UIBarButtonItem) {
        let viewControllers: [UIViewController] = _obj.nc5.viewControllers
        for descView in viewControllers {
            if(descView is TRCPasscodeLockSettingViewController){
                _obj.nc5.popToViewController(descView, animated: true)
            }
        }

    }
    
    //MARK: Action
    func textFieldDidChange(_ textField: UITextField){
        switch (tfPasscode.text?.characters.count as! Int) {
        case 1:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 2:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 3:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 4:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_circle")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let passcodeString = self.tfPasscode.text
                
                switch (self.mode) {
                case MODE_LOGIN:
                    let oldPasscode = UserDefaults.getUD(PASSCODE) as! String
                    if(passcodeString == oldPasscode){
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.configTabbar()
                        
                        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                            UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                        }, completion: { completed in
                            // maybe do something here
                        })
                    }else{
                        self.lblError.isHidden = false
                        self.lblError2.isHidden = false
                        
                        self.lblError.text = Localizable(value: "passcode_not_match")
                        self.lblError2.text = Localizable(value: "input_again")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.lblError.isHidden = true
                            self.lblError2.isHidden = true
                        }
                        
                        self.tfPasscode.text = ""
                        
                        self.imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
                    }
                case MODE_SETUP:
                    //save to dic
                    _obj.dicPasscode.updateValue(passcodeString!, forKey: DIC_PASSCODE)
                    
                    //push to confirm
                    let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
                    vc.mode = MODE_CONFIRM
                    self.configBackButton()
                    _obj.nc5.pushViewController(vc, animated: true)
                case MODE_CONFIRM:
                    //compare passcode
                    if(passcodeString == _obj.dicPasscode[DIC_PASSCODE]){
                        
                        //save to userdefault
                        UserDefaults.saveUD(passcodeString, PASSCODE)
                        
                        //pop to setting passcode
                        let viewControllers: [UIViewController] = _obj.nc5.viewControllers
                        for descView in viewControllers {
                            if(descView is TRCPasscodeLockSettingViewController){
                                _obj.nc5.popToViewController(descView, animated: true)
                            }
                        }
                    }else{
                        self.lblError.isHidden = false
                        self.lblError2.isHidden = false
                        
                        self.lblError.text = Localizable(value: "passcode_not_match")
                        self.lblError2.text = Localizable(value: "input_again")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.lblError.isHidden = true
                            self.lblError2.isHidden = true
                        }
                        
                        self.tfPasscode.text = ""
                        
                        //push to setup
                        let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
                        vc.mode = MODE_SETUP
                        self.configBackButton()
                        _obj.nc5.pushViewController(vc, animated: true)

                    }
                case MODE_CHANGE:
                    //input old passcode
                    let oldPasscode = UserDefaults.getUD(PASSCODE) as! String
                    if(passcodeString == oldPasscode){
                        let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
                        vc.mode = MODE_SETUP
                        vc.modeChange = MODE_SETUP_NEW
                        self.configBackButton()
                        _obj.nc5.pushViewController(vc, animated: true)
                    }else{
                        self.lblError.isHidden = false
                        self.lblError2.isHidden = false
                        
                        self.lblError.text = Localizable(value: "passcode_not_match")
                        self.lblError2.text = Localizable(value: "input_again")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.lblError.isHidden = true
                            self.lblError2.isHidden = true
                        }
                        
                        self.tfPasscode.text = ""
                        
                        self.imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
                    }
                case MODE_REMOVE:
                    let oldPasscode = UserDefaults.getUD(PASSCODE) as! String
                    if(passcodeString == oldPasscode){
                        //remove from userdefault
                        UserDefaults.removeUD(PASSCODE)
                        
                        //pop to setting passcode
                        let viewControllers: [UIViewController] = _obj.nc5.viewControllers
                        for descView in viewControllers {
                            if(descView is TRCPasscodeLockSettingViewController){
                                _obj.nc5.popToViewController(descView, animated: true)
                            }
                        }
                    }else{
                        self.lblError.isHidden = false
                        self.lblError2.isHidden = false
                        
                        self.lblError.text = Localizable(value: "passcode_not_match")
                        self.lblError2.text = Localizable(value: "input_again")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.lblError.isHidden = true
                            self.lblError2.isHidden = true
                        }
                        self.tfPasscode.text = ""
                        
                        self.imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
                        self.imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
                    }
                default:
                    break
                }
            }
            
        default:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        }
    }
}
