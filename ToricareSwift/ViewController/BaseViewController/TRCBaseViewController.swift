//
//  TRCBaseViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap to cancel keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //hide tabbar
        _obj.tabController.tabBar.isHidden = true
        
        //navigation
        _obj.nc1.navigationBar.isHidden = false
        _obj.nc2.navigationBar.isHidden = false
        _obj.nc3.navigationBar.isHidden = false
        _obj.nc4.navigationBar.isHidden = false
        _obj.nc5.navigationBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
    }

    //call this function when the tap is recognized
    func dismissKeyboard(){
        view.endEditing(true)
    }
}
