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
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = false
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
    
    //MARK: Customize tabbar 
    func configTabbar1(){
        //set background color for selected item
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: TABBAR_COLOR_1), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //setcolor for text
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
        
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
        
        //set image
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "menu_home_00").withRenderingMode(.alwaysOriginal)
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "menu_home_w").withRenderingMode(.alwaysOriginal)
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
    }
    
    func configTabbar2(){
        //set background color for selected item
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: TABBAR_COLOR_2), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //setcolor for text
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_2)]
        
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
        
        //set image
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "menu_home_01").withRenderingMode(.alwaysOriginal)
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "menu_home_w").withRenderingMode(.alwaysOriginal)
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
    }
    
    func configTabbar3(){
        //set background color for selected item
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: TABBAR_COLOR_3), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //setcolor for text
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_3)]
        
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
        
        //set image
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "menu_home_02").withRenderingMode(.alwaysOriginal)
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "menu_home_w").withRenderingMode(.alwaysOriginal)
        
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition").withRenderingMode(.alwaysOriginal)
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl").withRenderingMode(.alwaysOriginal)
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
    }
    
    func configTabbar4(){
        //set background color for selected item
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: TABBAR_COLOR_4), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //setcolor for text
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_4)]
        
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
        
        //set image
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "menu_home_03").withRenderingMode(.alwaysOriginal)
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "menu_home_w").withRenderingMode(.alwaysOriginal)
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
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
