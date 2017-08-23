//
//  TRCMyPharmacyDetailPageViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/25/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacyDetailPageViewController: GLViewPagerViewController {

    var viewControllers: NSArray = NSArray()
    var tabTitles: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        _obj.tabController.tabBar.isHidden = true

        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        
        configPageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }
    
    
    //MARK: Config page view
    func configPageView(){
        self.setDataSource(newDataSource: self)
        self.setDelegate(newDelegate: self)
        
        //default page
        self.defaultDisplayPageIndex = 0
        
        //indicator
        self.tabAnimationType = GLTabAnimationType.GLTabAnimationType_WhileScrolling
        self.indicatorColor = UIColor.init(hexString: MAIN_COLOR)
        
        //size of tab
        self.supportArabic = false
        self.tabWidth = view.frame.size.width / 2
        
        //init view
        let pharmacyDetailView = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
        let pharmacistView = TRCMyPharmacistDetailViewController(nibName: "TRCMyPharmacistDetailViewController", bundle: nil)
        self.viewControllers = [
            pharmacyDetailView,
            pharmacistView
        ]
            
        //set delegatge
        pharmacyDetailView.delegate = self
        pharmacistView.delegate = self
        
        
        //init title
        self.tabTitles = [Localizable(value: "my_pharmacy"), Localizable(value: "my_pharmacist")]
    }
    
    func configPageBackButton(){
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        self.navigationItem.backBarButtonItem = backItem

    }
}

extension TRCMyPharmacyDetailPageViewController: GLViewPagerViewControllerDataSource{
    func numberOfTabsForViewPager(_ viewPager: GLViewPagerViewController) -> Int {
        return self.viewControllers.count
    }
    
    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        //init label
        let label:UILabel = UILabel.init()
        label.text = self.tabTitles.object(at: index) as? String
        
        //style for label
        label.textColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        
        return label
    }
    
    func contentViewControllerForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIViewController {
        return self.viewControllers.object(at: index) as! UIViewController
    }
}

extension TRCMyPharmacyDetailPageViewController: GLViewPagerViewControllerDelegate{
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel
        
        prevLabel.textColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        currentLabel.textColor = UIColor.init(hexString: MAIN_COLOR)
    }
    
    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int, progress: CGFloat) {
        if fromTabIndex == index {
            return;
        }
        
    }
    
    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
        return (view.frame.size.width / 2)
    }
}

extension TRCMyPharmacyDetailPageViewController: TRCMyPharmacistDetailViewControllerDelegate {
    func pushToPharmacistInput(_ dicResult: NSDictionary) {
        let vc = TRCMyPharmacistInputViewController(nibName: "TRCMyPharmacistInputViewController", bundle: nil)
        vc.dataResult = dicResult
        self.configPageBackButton()
        _obj.nc5.pushViewController(vc, animated: true)
    }
}

extension TRCMyPharmacyDetailPageViewController: TRCMyPharmacyDetailViewControllerDelegate{
    func pushtoSearchView() {
        let vc = TRCPharmacySearchViewController(nibName: "TRCPharmacySearchViewController", bundle: nil)
        self.configPageBackButton()
        _obj.nc5.pushViewController(vc, animated: true)
    }
    
    func pushtoQRCodeView(_ mode: String) {
        let vc = TRCQRCodeViewController(nibName: "TRCQRCodeViewController", bundle: nil)
        vc.mode = mode
        self.configPageBackButton()
        _obj.nc5.pushViewController(vc, animated: true)

    }
}

