//
//  TRCPasscodeLockLoginInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/27/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasscodeLockLoginInputViewController: UIViewController {

    @IBOutlet weak var viewBorderImageIcon: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgViewIcon: UIImageView!
    
    @IBOutlet weak var viewBorderInputPasscode: UIView!
    
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
    
    @IBOutlet weak var lblError: UILabel!
    
    @IBOutlet weak var lblGuilde: UILabel!
    
    @IBOutlet weak var tfPasscode: UITextField!

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationController?.navigationBar.isHidden = true
        
        //UI
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewBorderImageIcon.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewBorderInputPasscode.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
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
        
//        lblError.isHidden = true
//        lblError2.isHidden = true
//        lblError.labelStyle(title: "", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: ERROR_COLOR)
//        lblError2.labelStyle(title: "", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: ERROR_COLOR)
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
            
            let passcodeString = tfPasscode.text
            
            let oldPasscode = UserDefaults.getUD(PASSCODE) as! String
            if(passcodeString == oldPasscode){
                UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                    UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
                }, completion: { completed in
                    // maybe do something here
                })
            }else{
//                lblError.isHidden = false
//                lblError2.isHidden = false
//                
//                lblError.text = Localizable(value: "passcode_not_match")
//                lblError2.text = Localizable(value: "input_again")
                
                tfPasscode.text = ""
                
                imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
                imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
                imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
                imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
            }
        default:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        }
    }
}
