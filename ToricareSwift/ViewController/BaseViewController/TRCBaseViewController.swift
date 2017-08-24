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
        
        //navigation
        _obj.nc1.setNavigationBarHidden(false, animated: true)
        _obj.nc2.setNavigationBarHidden(false, animated: true)
        _obj.nc3.setNavigationBarHidden(false, animated: true)
        _obj.nc4.setNavigationBarHidden(false, animated: true)
        _obj.nc5.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
    }

    //MARK: Action
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }
    
    //call this function when the tap is recognized
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func configBackButton(){
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func hideBar(){
        self.hidesBottomBarWhenPushed = true
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
    
    func showAlert(_ message: String, _ title: String = Localizable(value: "error")) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: Localizable(value: "ok"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
