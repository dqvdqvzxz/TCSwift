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
        btnRegister.buttonStyle(title: STRING_REGISTER, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        
        btnLogin.buttonStyle(title: STRING_DO_LOGIN, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
            }

    //MARK: Button Action
    @IBAction func tapBtnRegister(_ sender: Any) {
        let vc = TRCRegisterViewController(nibName: "TRCRegisterViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnLogin(_ sender: Any) {
        let vc = TRCLoginViewController(nibName: "TRCLoginViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
