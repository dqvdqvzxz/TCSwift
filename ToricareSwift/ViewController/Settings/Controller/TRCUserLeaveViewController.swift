//
//  TRCUserLeaveViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCUserLeaveViewController: TRCBaseViewController {

    @IBOutlet weak var lblTitleUserLeave: UILabel!
    @IBOutlet weak var lblConfirm: UILabel!
    @IBOutlet weak var lblCheckBox: UILabel!
    
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var viewCheckBox: UIView!
    @IBOutlet weak var viewBtnCheckBox: UIView!
    @IBOutlet weak var viewLblCheckBox: UIView!
    
    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var btnLeave: UIButton!
    
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
        self.navigationItem.title = STRING_SETTING_RESIGN
        
        //UI
        lblTitleUserLeave.text = Localizable(value: "confirm_before_leave")
        lblConfirm.text = Localizable(value: "agree_leave_message")
        lblCheckBox.text = Localizable(value: "agree")
        
        //btnLeave.buttonStyle(title: Localizable(value: "leave"))
        btnLeave.isEnabled = false
        //btnLeave.backgroundColor = UIColor.init(hexString: BACKGROUND_COLOR)
        btnLeave.buttonStyle(title: Localizable(value: "leave"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BACKGROUND_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        
        //add action tap check box for button check box and view check box
        btnCheckBox.addTarget(self, action: #selector(tapCheckBox), for: .touchUpInside)
        
        ///viewCheckBox.backgroundColor = UIColor.init(hexString: BACKGROUND_COLOR)
        let gestureViewCheckBox = UITapGestureRecognizer(target: self, action: #selector(tapCheckBox))
        viewCheckBox.addGestureRecognizer(gestureViewCheckBox)
    }
    
    //MARK: Action
    func tapCheckBox(){
        btnCheckBox.isSelected = !btnCheckBox.isSelected
        if(btnCheckBox.isSelected){
            btnLeave.isEnabled = true
            btnLeave.buttonStyle(title: Localizable(value: "leave"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: MAIN_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        }else if(!btnCheckBox.isSelected){
            btnLeave.isEnabled = false
            btnLeave.buttonStyle(title: Localizable(value: "leave"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BACKGROUND_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnLeave(_ sender: Any) {
        let alert = UIAlertController(title: Localizable(value: "leave_confirm"),
                                      message: Localizable(value: "really_want_leave_message"),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        // add the action
        alert.addAction(UIAlertAction(title: Localizable(value: "cancel"),
                                      style: UIAlertActionStyle.cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
                                      style: UIAlertActionStyle.default,
                                      handler: { action in
                                        let vc = TRCUserLeaveCompleteViewController(nibName: "TRCUserLeaveCompleteViewController", bundle: nil)
                                        _obj.nc5.pushViewController(vc, animated: true)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}
