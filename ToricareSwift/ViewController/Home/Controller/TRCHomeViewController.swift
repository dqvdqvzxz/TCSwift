//
//  TRCHomeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCHomeViewController: TRCBaseViewController {
    
    @IBOutlet weak var tabBar: UITabBar!
    
    @IBOutlet weak var tabSetting: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        testBtn.buttonStyle(title: "Test BTN", fontSize: 7, titleColor: "0caa7d", borderWidth: 1, borderColor: "nil", radius: nil, backgroundColor: nil)
//        
//        testLabel.labelStyle(title: "Test Label", fontSize: 20, textColor: "0caa7d")
//        
//        textTextField.textFieldStyle(placeHolder: "Test Place hoder", fontSize: 15, textColor: "0caa7d", borderWidth: 1, borderColor: "a6d4ca", radius: 5, backgroundColor: "a6d4ca")
//        
//        TRCLoginAPIController().Login("", "", completion: {
//            //xu ly hien thi du lieu khi pass
//            DLog("1")
//            
//        }) { (String) in
//            //khi fail
//            DLog("2")
//        }
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
//        self.navigationController?.navigationBar.topItem?.title = kTitleHome
//        self.navigationController?.navigationBar.backItem?.title = kBackButton
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: BUTTON_TITLE_COLOR)]
        self.navigationItem.title = kTitleHome
        
        tabBar.barTintColor = UIColor.init(hexString: MAIN_COLOR)
        tabBar.tintColor = UIColor.init(hexString: BUTTON_TITLE_COLOR)
        
        tabSetting.title = "Setting"
    }
}


extension TRCHomeViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 5){
            let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = kBackButton
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
