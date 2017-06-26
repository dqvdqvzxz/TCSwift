//
//  TRCPreLoginViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPreLoginViewController: TRCBaseViewController {

    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Congig UI
    func configUI(){
        btnRegister.layer.borderWidth = 1
        
        btnLogin.layer.borderWidth = 1
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    //MARK: Button Action 
    @IBAction func tapBtnLogin(_ sender: Any) {
        let vc = TRCLoginViewController(nibName: "TRCLoginViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
