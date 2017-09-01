//
//  TRCObject.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

final class Singleton{
    static let shared = Singleton()

    //navigation
    var nc1 = UINavigationController()
    var nc2 = UINavigationController()
    var nc3 = UINavigationController()
    var nc4 = UINavigationController()
    var nc5 = UINavigationController()
    
    //tabbar
    var tabController = UITabBarController()
    
    //dictionary
    var dicFacebookInfo = [String:String]()
    
    var dicPasscode = [String:String]()

    var objectGoal: TRCGoal!
    
    var newStep = ""
    
    var objectAccountInfo: TRCAccountInfo!
    
    var objectSummary: TRCSummary!
    
    var objectPharmacist: TRCPharmacist!
    
    var mode =  String()
    
    func clearObject(){
        objectGoal = nil
        objectSummary = nil
        objectAccountInfo = nil
        
        dicPasscode.removeAll()
        dicFacebookInfo.removeAll()
    }
    
    func initTabbarController(){
        //init tabbar
        let vc1 = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let vc2 = TRCTab2ViewController(nibName: "TRCTab2ViewController", bundle: nil)
        let vc3 = TRCTab3ViewController(nibName: "TRCTab3ViewController", bundle: nil)
        let vc4 = TRCTab4ViewController(nibName: "TRCTab4ViewController", bundle: nil)
        let vc5 = TRCMyPageViewController(nibName: "TRCMyPageViewController", bundle: nil)
        
        //init root nav controller
        let nc1 = _obj.nc1
        let nc2 = _obj.nc2
        let nc3 = _obj.nc3
        let nc4 = _obj.nc4
        let nc5 = _obj.nc5
        
        //init tabbar
        nc1.viewControllers = [vc1]
        nc2.viewControllers = [vc2]
        nc3.viewControllers = [vc3]
        nc4.viewControllers = [vc4]
        nc5.viewControllers = [vc5]
        _obj.tabController.viewControllers = [nc1, nc2, nc3, nc4, nc5]
        
        //set title for tab item
        _obj.tabController.tabBar.items?[0].title = STRING_TAB_HOME
        _obj.tabController.tabBar.items?[1].title = STRING_TAB_NUTRITION
        _obj.tabController.tabBar.items?[2].title = STRING_TAB_EXERCISE
        _obj.tabController.tabBar.items?[3].title = STRING_TAB_MEDICINE
        _obj.tabController.tabBar.items?[4].title = STRING_TAB_MYPAGE
        
        //set default tab
        _obj.tabController.selectedIndex = 0
    }
    
    //MARK: Customize tabbar
    func customizeTabbar(_ tabIndex: Int){
        
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        var unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
        
        var backgroundImage: String = ""
        
        var tab0Image: UIImage!
        var tab1Image: UIImage!
        var tab2Image: UIImage!
        var tab3Image: UIImage!
        var tab4Image: UIImage!
        
        switch tabIndex {
        case 0:
            backgroundImage = TABBAR_COLOR_1
            
            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
            
            tab0Image = #imageLiteral(resourceName: "menu_home_00")
            tab1Image = #imageLiteral(resourceName: "menu_syokuji_00")
            tab2Image = #imageLiteral(resourceName: "menu_katsudou_00")
            tab3Image = #imageLiteral(resourceName: "menu_okusuri_00")
            tab4Image = #imageLiteral(resourceName: "menu_mypage_00")
        case 1:
            backgroundImage = TABBAR_COLOR_2
            
            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_2)]
            
            tab0Image = #imageLiteral(resourceName: "menu_home_01")
            tab1Image = #imageLiteral(resourceName: "menu_syokuji_01")
            tab2Image = #imageLiteral(resourceName: "menu_katsudou_01")
            tab3Image = #imageLiteral(resourceName: "menu_okusuri_01")
            tab4Image = #imageLiteral(resourceName: "menu_mypage_01")
        case 2:
            backgroundImage = TABBAR_COLOR_3
            
            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_3)]
            
            tab0Image = #imageLiteral(resourceName: "menu_home_02")
            tab1Image = #imageLiteral(resourceName: "menu_syokuji_02")
            tab2Image = #imageLiteral(resourceName: "menu_katsudou_02")
            tab3Image = #imageLiteral(resourceName: "menu_okusuri_02")
            tab4Image = #imageLiteral(resourceName: "menu_mypage_02")
        case 3:
            backgroundImage = TABBAR_COLOR_4
            
            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_4)]
            
            tab0Image = #imageLiteral(resourceName: "menu_home_03")
            tab1Image = #imageLiteral(resourceName: "menu_syokuji_03")
            tab2Image = #imageLiteral(resourceName: "menu_katsudou_03")
            tab3Image = #imageLiteral(resourceName: "menu_okusuri_03")
            tab4Image = #imageLiteral(resourceName: "menu_mypage_03")
        case 4:
            backgroundImage = TABBAR_COLOR_1
            
            unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: TABBAR_COLOR_1)]
            
            tab0Image = #imageLiteral(resourceName: "menu_home_00")
            tab1Image = #imageLiteral(resourceName: "menu_syokuji_00")
            tab2Image = #imageLiteral(resourceName: "menu_katsudou_00")
            tab3Image = #imageLiteral(resourceName: "menu_okusuri_00")
            tab4Image = #imageLiteral(resourceName: "menu_mypage_00")
        default:
            break
        }
        
        //set background color for selected item
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString:backgroundImage), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        //set image
        _obj.tabController.tabBar.items?[0].image = convertImage(tab0Image)
        _obj.tabController.tabBar.items?[0].selectedImage = convertImage(#imageLiteral(resourceName: "menu_home_w"))
        
        _obj.tabController.tabBar.items?[1].image = convertImage(tab1Image)
        _obj.tabController.tabBar.items?[1].selectedImage = convertImage(#imageLiteral(resourceName: "menu_syokuji_w"))
        
        _obj.tabController.tabBar.items?[2].image = convertImage(tab2Image)
        _obj.tabController.tabBar.items?[2].selectedImage = convertImage(#imageLiteral(resourceName: "menu_katsudou_w"))
        
        _obj.tabController.tabBar.items?[3].image = convertImage(tab3Image)
        _obj.tabController.tabBar.items?[3].selectedImage = convertImage(#imageLiteral(resourceName: "menu_okusuri_w"))
        
        _obj.tabController.tabBar.items?[4].image = convertImage(tab4Image)
        _obj.tabController.tabBar.items?[4].selectedImage = convertImage(#imageLiteral(resourceName: "menu_mypage_w"))
        
        //setcolor for text
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
    }
    
    func convertImage(_ image: UIImage) -> UIImage{
        return image.withRenderingMode(.alwaysOriginal)
    }
}

