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
    
    @IBOutlet weak var viewPage: UIView!
    
    //sub view tutorial
    @IBOutlet var viewParentTutorial: UIView!
    @IBOutlet weak var viewTutorial: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewContent: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnReaded: UIButton!

    @IBOutlet weak var lblGuide: UILabel!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
        _obj.tabController.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = false
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        
        //UI of outlet
        lblInform.labelStyle(title: Localizable(value: "please_register_your_pharmacy"))
        
        viewPage.clipsToBounds = true
        
        //set up page view
        configPageView()
        
        //set up tutorial view
        if(_obj.mode == MODE_MYPAGE){
            //hide tutorial
        }else if(_obj.mode == MODE_REGISTER){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
            
            configTutorialView()
        }
    }
    
    func configPageView(){
        let pageVC =  TRCSearchPageViewController(nibName: "TRCSearchPageViewController", bundle: nil)
        pageVC.searchTextPageView.delegate = self
        pageVC.searchLocationPageView.delegate = self
        pageVC.searchCurrentLocationPageView.delegate = self
        viewPage.addSubview(pageVC.view)
    }
    
    func configTutorialView(){
        //UI
        lblGuide.labelStyle(title: "My薬局、\nMy薬剤師の説明")
        btnReaded.buttonStyle()
        btnReaded.setTitle(Localizable(value: "close"), for: UIControlState.normal)

        btnCancel.setTitle("", for: .normal)
        viewParentTutorial.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
        
        //add to self view
        let currentWindow = UIApplication.shared.keyWindow
        viewParentTutorial.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        currentWindow?.addSubview(viewParentTutorial)
    }
    
    func configPageBackButton(){
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        self.navigationItem.backBarButtonItem = backItem
        
    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        _obj.mode = MODE_SKIP
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    @IBAction func tapBtnCancel(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
    
    @IBAction func tapBtnReaded(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
}

extension TRCPharmacySearchViewController: TRCSearchTextPageViewDelegate {
    func pushTextToSearchResult(_ mode: String) {
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
        self.configPageBackButton()
        if(mode == MODE_MYPAGE){
            _obj.nc5.pushViewController(vc, animated: true)
        }else if(mode == MODE_REGISTER){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension TRCPharmacySearchViewController: TRCSearchLocationPageViewDelegate {
    func pushLocationToSearchResult(_ mode: String) {
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
        self.configPageBackButton()
        if(mode == MODE_MYPAGE){
            _obj.nc5.pushViewController(vc, animated: true)
        }else if(mode == MODE_REGISTER){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func openLoading() {
        //
    }
    
    func closeLoading() {
        //
    }
}

extension TRCPharmacySearchViewController: TRCSearchCurrentLocationPageViewDelegate {
    func pushCurrentLocationToSearchResult(_ mode: String) {
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
        self.configPageBackButton()
        if(mode == MODE_MYPAGE){
            _obj.nc5.pushViewController(vc, animated: true)
        }else if(mode == MODE_REGISTER){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
