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
        
        self.padding = 10
        self.leadingPadding = 10
        self.trailingPadding = 10
        
        //default page
        self.defaultDisplayPageIndex = 0
        
        //indicator
        self.tabAnimationType = GLTabAnimationType.GLTabAnimationType_WhileScrolling
        self.indicatorColor = UIColor.init(hexString: MAIN_COLOR)
        
        self.supportArabic = false
        self.fixTabWidth = false
        
        //init view
        self.viewControllers = [
            UIViewController(nibName: "TRCSearchLocationPageView", bundle: nil),
            UIViewController(nibName: "TRCSearchCurrentLocationPageView", bundle: nil)
        ]
        
        //init title
        self.tabTitles = [ "Button 1", "Button 2"]

    }
}

extension TRCSearchPageViewController: GLViewPagerViewControllerDataSource{
    func numberOfTabsForViewPager(_ viewPager: GLViewPagerViewController) -> Int {
        return self.viewControllers.count
    }
    
    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        let label:UILabel = UILabel.init()
        label.text = self.tabTitles.object(at: index) as? String
        label.textColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
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
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        prevLabel.textColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
        currentLabel.textColor = UIColor.init(colorLiteralRed: 0.5, green: 0.0, blue: 0.5, alpha: 1.0)
    }
    
    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int, progress: CGFloat) {
        if fromTabIndex == index {
            return;
        }
        
        let prevLabel:UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as! UILabel
        let currentLabel:UILabel = viewPager.tabViewAtIndex(index: index) as! UILabel
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0 - (0.1 * progress), y: 1.0 - (0.1 * progress))
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9 + (0.1 * progress), y: 0.9 + (0.1 * progress))
        currentLabel.textColor =  UIColor.init(colorLiteralRed: Float(0.3 + 0.2 * progress), green: Float(0.3 - 0.3 * progress), blue: Float(0.3 + 0.2 * progress), alpha: 1.0)
        prevLabel.textColor = UIColor.init(colorLiteralRed: Float(0.5 - 0.2 * progress), green: Float(0.0 + 0.3 * progress), blue: Float(0.5 - 0.2 * progress), alpha: 1.0)
    }
    
    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
//        let prototypeLabel:UILabel = UILabel.init()
//        prototypeLabel.text = self.tabTitles.object(at: index) as? String
//        prototypeLabel.textAlignment = NSTextAlignment.center
//        prototypeLabel.font = UIFont.systemFont(ofSize: 16.0)
        print(view.frame.size.width)
        print(view.frame.size.width/2)
        return (view.frame.size.width / 2)
    }
}
