//
//  TRCBaseViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import MBProgressHUD

class TRCBaseViewController: UIViewController {

    //MARK: View contorller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGlobalUI()
        
        print(self.navigationController?.viewControllers)
        print(self.navigationController?.viewControllers.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configGlobalUI(){
        //tap to cancel keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //hide tabbar
        _obj.tabController.tabBar.isHidden = true
        
        //navigation
        _obj.nc1.setNavigationBarHidden(false, animated: true)
        _obj.nc2.setNavigationBarHidden(false, animated: true)
        _obj.nc3.setNavigationBarHidden(false, animated: true)
        _obj.nc4.setNavigationBarHidden(false, animated: true)
        _obj.nc5.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
        
    }

    //MARK: Action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    //call this function when the tap is recognized
    func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension UIViewController {
    func showHUD(_ message: String = Localizable(value: "loading")) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = message
        hud.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
