//
//  TRCQRCodeDoneViewController.swift
//  ToricareSwift
//
//  Created by tuan on 8/1/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCQRCodeDoneViewController: TRCBaseViewController {

    @IBOutlet weak var lblSucceed: UILabel!
    @IBOutlet weak var lblPharmacyName: UILabel!
    @IBOutlet weak var btnBackToTop: UIButton!
    var mode = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated:true);

//        self.navigationController?.navigationItem.setLeftBarButton(nil, animated: false)
//        self.navigationItem.setLeftBarButton(nil, animated: false)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func configUI() {
        self.navigationItem.title = Localizable(value: "qr_title")

        lblSucceed.labelStyle(title: Localizable(value: "register_my_pharmacy_done"))
        
        btnBackToTop.buttonStyle(title: mode == MODE_REGISTER_MYPAGE ? Localizable(value: "back_to_mypage") : Localizable(value: "back_to_top"))
        btnBackToTop.addTarget(self, action: #selector(btnBackToTopDidTap), for: UIControlEvents.touchUpInside)
        
    }
    
    func btnBackToTopDidTap() {
        if (mode == MODE_REGISTER_MYPAGE) {
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers
            for descView in viewControllers {
                if(descView is TRCMyPageViewController){
                    _obj.nc5.popToViewController(descView, animated: true)
                }
            }
        } else {
            //init tab bar controller
            _obj.initTabbarController()

            UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
                UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
            }, completion: { completed in
                // maybe do something here
            })
        }
    }
}
