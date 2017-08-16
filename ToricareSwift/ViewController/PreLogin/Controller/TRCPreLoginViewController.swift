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

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: Congig UI
    func configUI(){
        btnRegister.buttonStyle(title: STRING_REGISTER)
        
        btnLogin.buttonStyle(title: STRING_DO_LOGIN)
    }

    //MARK: Button Action
    @IBAction func tapBtnRegister(_ sender: Any) {
        let vc = TRCRegisterViewController(nibName: "TRCRegisterViewController", bundle: nil)
        backButton()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        let vc = TRCLoginViewController(nibName: "TRCLoginViewController", bundle: nil)
        backButton()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
