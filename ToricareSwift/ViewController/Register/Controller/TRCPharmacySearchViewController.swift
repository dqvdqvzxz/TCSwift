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
    
    @IBOutlet weak var btnSearch: UIButton!
    
    //sub view tutorial
    @IBOutlet var viewParentTutorial: UIView!
    @IBOutlet weak var viewTutorial: UIView!
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var viewContent: UIView!

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnReaded: UIButton!

    var mode = String()

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        
//        vc.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "my_pharmacy_setting")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
        
        //UI of outlet
        lblInform.labelStyle(title: Localizable(value: "please_register_your_pharmacy"))
        
        btnSearch.buttonStyle(title: STRING_SEARCH)
        
        tfSearch.textFieldStyle(placeHolder: Localizable(value: "hint_search_by_name"))
        tfSearch.addRightImage(#imageLiteral(resourceName: "ic_search"))
        
        viewPage.clipsToBounds = true
        
        //set up page view
        configPageView()
        
        //set up tutorial view
        if(mode == "OffTutorial"){
            //hide tutorial
        }else{
            configTutorialView()
        }
    }
    
    func configPageView(){
        let pageVC =  TRCSearchPageViewController(nibName: "TRCSearchPageViewController", bundle: nil)
        viewPage.addSubview(pageVC.view)
    }
    
    func configTutorialView(){
        //UI
        btnCancel.setTitle("", for: .normal)
        btnReaded.buttonStyle(title: "")
        
        viewParentTutorial.backgroundColor = UIColor.init(hexString: "000000", alpha: 0.5)
        
        //add to self view
        self.view.addSubview(viewParentTutorial)
    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        vc.mode = MODE_SKIP
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }

    //MARK: Button Action
    @IBAction func tapBtnSearch(_ sender: Any) {
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBtnCancel(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
    
    @IBAction func tapBtnReaded(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
}
