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
    
//    //MARK: Customize tabbar 
//    func customizeTabbar(_ tabIndex: Int){
//        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
//        var unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
//        
//        var backgroundImage: String = ""
//        
//        var tab0Image: UIImage!
//        var tab1Image: UIImage!
//        var tab2Image: UIImage!
//        var tab3Image: UIImage!
//        var tab4Image: UIImage!
//        
//        switch tabIndex {
//        case 0:
//            backgroundImage = TABBAR_COLOR_1
//            
//            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
//            
//            tab0Image = #imageLiteral(resourceName: "menu_home_00")
//            tab1Image = #imageLiteral(resourceName: "menu_syokuji_00")
//            tab2Image = #imageLiteral(resourceName: "menu_katsudou_00")
//            tab3Image = #imageLiteral(resourceName: "menu_okusuri_00")
//            tab4Image = #imageLiteral(resourceName: "menu_mypage_00")
//        case 1:
//            backgroundImage = TABBAR_COLOR_2
//            
//            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_2)]
//            
//            tab0Image = #imageLiteral(resourceName: "menu_home_01")
//            tab1Image = #imageLiteral(resourceName: "menu_syokuji_01")
//            tab2Image = #imageLiteral(resourceName: "menu_katsudou_01")
//            tab3Image = #imageLiteral(resourceName: "menu_okusuri_01")
//            tab4Image = #imageLiteral(resourceName: "menu_mypage_01")
//        case 2:
//            backgroundImage = TABBAR_COLOR_3
//            
//            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_3)]
//
//            tab0Image = #imageLiteral(resourceName: "menu_home_02")
//            tab1Image = #imageLiteral(resourceName: "menu_syokuji_02")
//            tab2Image = #imageLiteral(resourceName: "menu_katsudou_02")
//            tab3Image = #imageLiteral(resourceName: "menu_okusuri_02")
//            tab4Image = #imageLiteral(resourceName: "menu_mypage_02")
//        case 3:
//            backgroundImage = TABBAR_COLOR_4
//            
//            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_4)]
//
//            tab0Image = #imageLiteral(resourceName: "menu_home_03")
//            tab1Image = #imageLiteral(resourceName: "menu_syokuji_03")
//            tab2Image = #imageLiteral(resourceName: "menu_katsudou_03")
//            tab3Image = #imageLiteral(resourceName: "menu_okusuri_03")
//            tab4Image = #imageLiteral(resourceName: "menu_mypage_03")
//        default:
//            break
//        }
//        
//        //set background color for selected item
//        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString:backgroundImage), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
//
//        //set image
//        _obj.tabController.tabBar.items?[0].image = convertImage(tab0Image)
//        _obj.tabController.tabBar.items?[0].selectedImage = convertImage(#imageLiteral(resourceName: "menu_home_w"))
//        
//        _obj.tabController.tabBar.items?[1].image = convertImage(tab1Image)
//        _obj.tabController.tabBar.items?[1].selectedImage = convertImage(#imageLiteral(resourceName: "menu_syokuji_w"))
//        
//        _obj.tabController.tabBar.items?[2].image = convertImage(tab2Image)
//        _obj.tabController.tabBar.items?[2].selectedImage = convertImage(#imageLiteral(resourceName: "menu_katsudou_w"))
//        
//        _obj.tabController.tabBar.items?[3].image = convertImage(tab3Image)
//        _obj.tabController.tabBar.items?[3].selectedImage = convertImage(#imageLiteral(resourceName: "menu_okusuri_w"))
//        
//        _obj.tabController.tabBar.items?[4].image = convertImage(tab4Image)
//        _obj.tabController.tabBar.items?[4].selectedImage = convertImage(#imageLiteral(resourceName: "menu_mypage_w"))
//        
//        //setcolor for text
//        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(unSelectedItem, for: .normal)
//        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(selectedItem, for: .selected)
//        
//        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(unSelectedItem, for: .normal)
//        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(selectedItem, for: .selected)
//        
//        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(unSelectedItem, for: .normal)
//        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(selectedItem, for: .selected)
//        
//        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(unSelectedItem, for: .normal)
//        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(selectedItem, for: .selected)
//        
//        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(unSelectedItem, for: .normal)
//        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(selectedItem, for: .selected)
//    }
// 
//    func convertImage(_ image: UIImage) -> UIImage{
//        return image.withRenderingMode(.alwaysOriginal)
//    }
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
