//
//  TRCSearchPageViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/17/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit


class TRCSearchPageViewController: GLViewPagerViewController {

    var viewControllers: NSArray = NSArray()
    var tabTitles: NSArray = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        configPageView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let searchPageView = TRCSearchLocationPageView(nibName: "TRCSearchLocationPageView", bundle: nil)
        searchPageView.delegate = self
        let searchCurrentLocationPageView = TRCSearchCurrentLocationPageView(nibName: "TRCSearchCurrentLocationPageView", bundle: nil)
        self.viewControllers = [
            searchPageView,
            searchCurrentLocationPageView
        ]
        
        //init title
        self.tabTitles = [Localizable(value: "search_by_prefecture"), Localizable(value: "search_by_current_location")]
    }
}

extension TRCSearchPageViewController: GLViewPagerViewControllerDataSource{
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

extension TRCSearchPageViewController: GLViewPagerViewControllerDelegate{
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel

        prevLabel.textColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        currentLabel.textColor = UIColor.init(hexString: MAIN_COLOR)
        
        if(index == 0){
            UserDefaults.saveUD(index, SEARCH_TAB)
        }else if(index == 1){
            UserDefaults.saveUD(index, SEARCH_TAB)
        }
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

extension TRCSearchPageViewController: TRCSearchLocationPageViewDelegate {
    func openLoading() {
        self.showHUD()
    }
    
    func closeLoading() {
        self.hideHUD()
    }
}
