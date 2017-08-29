//
//  TRCTab3ViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/1/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCTab3ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        //init tabbar
//        UITabBar.appearance().backgroundColor = UIColor.init(hexString: MAIN_COLOR)
//        UITabBar.appearance().tintColor = UIColor.init(hexString: "00532e")
//        
//        //set image for tab item
//        _obj.tabController.tabBar.items?[0].image = UIImage(named: "menu_home_02.png")
//        _obj.tabController.tabBar.items?[0].selectedImage = UIImage(named: "menu_home_w.png")
//        
//        _obj.tabController.tabBar.items?[1].image = UIImage(named: "menu_syokuji_02.png")
//        _obj.tabController.tabBar.items?[1].selectedImage = UIImage(named: "menu_syokuji_w.png")
//        
//        _obj.tabController.tabBar.items?[2].image = UIImage(named: "menu_katsudou_02.png")
//        _obj.tabController.tabBar.items?[2].selectedImage = UIImage(named: "menu_katsudou_w.png")
//        
//        _obj.tabController.tabBar.items?[3].image = UIImage(named: "menu_okusuri_02.png")
//        _obj.tabController.tabBar.items?[3].selectedImage = UIImage(named: "menu_okusuri_w.png")
//        
//        _obj.tabController.tabBar.items?[4].image = UIImage(named: "menu_mypage_02.png")
//        _obj.tabController.tabBar.items?[4].selectedImage = UIImage(named: "menu_mypage_w.png")

        
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: "c12f5b")]
        
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(selectedItem, for: .selected)
        
        
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "home")
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "home_hl")
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
        
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: "c12f5b"), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
//        //push to home view
//        UIView.transition(with: self.view, duration: 0.5, options: .transitionFlipFromLeft, animations: {
//            UIApplication.shared.keyWindow?.rootViewController = _obj.tabController
//            _obj.tabController.selectedIndex = 0
//        }, completion: { completed in
//            // maybe do something here
//        })

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
