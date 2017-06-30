//
//  TRCHomeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCHomeViewController: TRCBaseViewController {

    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var textTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testBtn.styleButton(title: "Test BTN", fontSize: 7, titleColor: "0caa7d", borderWidth: 1, borderColor: "a6d4ca", radius: 10, backgroundColor: nil)
        
        testLabel.styleLabel(title: "Test Label", fontSize: 20, textColor: "0caa7d")
        
        textTextField.textFieldStyle(placeHolder: "Test Place hoder", fontSize: 15, textColor: "0caa7d", borderWidth: 1, borderColor: "a6d4ca", radius: 5, backgroundColor: "a6d4ca")
        
        TRCLoginAPIController().Login("", "", completion: {
            //xu ly hien thi du lieu khi pass
            DLog("1")
            
        }) { (String) in
            //khi fail
            DLog("2")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
