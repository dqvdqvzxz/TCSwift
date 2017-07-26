//
//  TRCUserLeaveCompleteViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCUserLeaveCompleteViewController: TRCBaseViewController {

    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    
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
        self.navigationItem.hidesBackButton = true
        
        //UI
        lblTitle1.text = Localizable(value: "leave_complete")
        lblTitle2.text = Localizable(value: "thank_you")
        
        imgView.image = #imageLiteral(resourceName: "img_user_test")
    }
}
