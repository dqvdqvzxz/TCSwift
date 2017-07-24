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
        self.navigationItem.title = ""
        
        //UI
        btnLeave.isEnabled = false
        btnLeave.backgroundColor = UIColor.init(hexString: BACKGROUND_COLOR)
        
        //add action tap check box for button check box and view check box
        btnCheckBox.addTarget(self, action: #selector(tapCheckBox), for: .touchUpInside)
        
        let gestureViewCheckBox = UITapGestureRecognizer(target: self, action: #selector(tapCheckBox))
        viewCheckBox.addGestureRecognizer(gestureViewCheckBox)
    }
    
    //MARK: Action
    func tapCheckBox(){
        btnCheckBox.isSelected = !btnCheckBox.isSelected
        if(btnCheckBox.isSelected){
            btnLeave.isEnabled = true
            btnLeave.backgroundColor = UIColor.init(hexString: MAIN_COLOR)
        }else if(!btnCheckBox.isSelected){
            btnLeave.isEnabled = false
            btnLeave.backgroundColor = UIColor.init(hexString: BACKGROUND_COLOR)
        }
    }
    
    //MARK: Button Action
    @IBAction func tapBtnLeave(_ sender: Any) {
 
    }
}
