//
//  TRCLoginViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCLoginViewController: TRCBaseViewController {

    @IBOutlet weak var btnLoginWithFB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
        TRCLoginAPIController().Login("", "", completion: {
            DLog("1")
        }) { (String) in
            DLog("2")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = kTitleLogin

        btnLoginWithFB.layer.backgroundColor = UIColor.blue.cgColor
        btnLoginWithFB.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

    @IBAction func tapBtnLoginWithFB(_ sender: Any) {
    }
    
    
}


