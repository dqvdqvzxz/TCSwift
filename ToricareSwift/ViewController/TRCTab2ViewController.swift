//
//  TRCTab2ViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/1/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCTab2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //init tabbar
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.configTabbar()
        
        //push to home view
        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
            _obj.tabController.selectedIndex = 0
        }, completion: { completed in
            // maybe do something here
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
