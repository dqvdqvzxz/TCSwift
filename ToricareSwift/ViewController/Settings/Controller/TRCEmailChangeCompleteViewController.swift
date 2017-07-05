//
//  TRCEmailChangeCompleteViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCEmailChangeCompleteViewController: TRCBaseViewController {

    @IBOutlet weak var btnBackToMyPage: UIButton!
    
    //MARL: View controller
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
        self.navigationItem.title = kChangeEmail
        
        //UI of outlet
        btnBackToMyPage.buttonStyle(title: kBackToMyPage, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
    }
    
    //MARK: Button Action
    @IBAction func tapBtnBackToMyPage(_ sender: Any) {
        let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = kBackButton
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
