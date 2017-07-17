//
//  TRCPharmacySearchViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPharmacySearchViewController: TRCBaseViewController {

    @IBOutlet weak var lblInform: UILabel!
    
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var viewPage: UIView!
    @IBOutlet weak var viewBtnSearchLocation: UIView!
    @IBOutlet weak var viewBtnSearchCurrentLocation: UIView!
    @IBOutlet weak var viewContent: UIView!
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnSearchLocation: UIButton!
    @IBOutlet weak var btnSearchCurrentLocation: UIButton!
    
    let pageViewController = UIPageViewController()
    
    var pageSelectedButton = UIButton()
    
    let pageContentViewController = [
        UIViewController(nibName: "TRCSearchLocationPageView", bundle: nil),
        UIViewController(nibName: "TRCSearchCurrentLocationPageView", bundle: nil)
    ]

    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        //UI of outlet
        btnSearch.buttonStyle(title: STRING_SEARCH)
        
        //set up page view
        configPageView()
    }
    
    func configPageView(){
        pageViewController.dataSource = self
        
        pageViewController.setViewControllers([pageContentViewController.first!], direction: .forward, animated: true, completion: nil)
        pageViewController.view.frame = viewContent.bounds
        
        viewContent.addSubview(pageViewController.view)
        
        btnSearchLocation.addTarget(self, action: #selector(tapBtnSearch(_:)), for: .touchUpInside)
        btnSearchCurrentLocation.addTarget(self, action: #selector(tapBtnSearch(_:)), for: .touchUpInside)
        
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    //MARK: Action
    func tapPageButton(_ button: UIButton){
        let selectedButtonIndex: NSInteger!
        pageSelectedButton = button
        
        if(button == btnSearchLocation){
            selectedButtonIndex = 0
        }else{
            selectedButtonIndex = 1
        }
        
        pageViewController.setViewControllers([pageContentViewController[selectedButtonIndex]], direction: .forward, animated: true, completion: nil)
    }

    //Button Action
    @IBAction func tapBtnSearch(_ sender: Any) {
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TRCPharmacySearchViewController: UIPageViewControllerDataSource{
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageContentViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pageContentViewController.index(of: viewController)!
        let previousIndex = abs((currentIndex - 1) % pageContentViewController.count)
        return pageContentViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pageContentViewController.index(of: viewController)!
        let nextIndex = abs((currentIndex + 1) % pageContentViewController.count)
        return pageContentViewController[nextIndex]
    }
}
