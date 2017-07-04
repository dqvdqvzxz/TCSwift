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
        
        //set main color for navigation bar
        UINavigationBar.appearance().backgroundColor = UIColor.init(hexString: MAIN_COLOR)
        UINavigationBar.appearance().barTintColor = UIColor.init(hexString: MAIN_COLOR)
        UINavigationBar.appearance().tintColor = UIColor.init(hexString: BUTTON_TITLE_COLOR)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.init(hexString: BUTTON_TITLE_COLOR)]
        self.navigationController?.navigationBar.backItem?.title = kBackButton
        self.navigationController?.setNavigationBarHidden(false, animated: false)

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
