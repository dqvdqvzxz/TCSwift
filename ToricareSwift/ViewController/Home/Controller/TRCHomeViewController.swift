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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testBtn.styleButton(title: "Test BTN", fontSize: 7, titleColor: "0caa7d", borderWidth: 1, borderColor: "a6d4ca", radius: 10, backgroundColor: "ff00ff")
        
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
