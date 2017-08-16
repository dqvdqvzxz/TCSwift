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

    @IBOutlet weak var lblGuide: UILabel!
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
        
        
        //UI of outlet
        lblInform.labelStyle(title: Localizable(value: "please_register_your_pharmacy"))
        
        btnSearch.buttonStyle(title: STRING_SEARCH)
        
        tfSearch.textFieldStyle(placeHolder: Localizable(value: "hint_search_by_name"))
        tfSearch.addRightImage(#imageLiteral(resourceName: "ic_search"))
        
        viewPage.clipsToBounds = true
        
        //set up page view
        configPageView()
        
        //set up tutorial view
        if(mode == MODE_MYPAGE){
            //hide tutorial
        }else if(mode == MODE_REGISTER){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
            
            configTutorialView()
        }
    }
    
    func configPageView(){
        let pageVC =  TRCSearchPageViewController(nibName: "TRCSearchPageViewController", bundle: nil)
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
        // comment it out 
//        self.view.addSubview(viewParentTutorial)
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
        if(mode == MODE_REGISTER){
            let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
            vc.mode = MODE_REGISTER
            //data search
            if(self.tfSearch.text != nil){
                UserDefaults.saveUD(self.tfSearch.text, SEARCH_KEYWORD)
            }
                
            //back button
            backButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            backButton()
            self.navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    @IBAction func tapBtnCancel(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
    
    @IBAction func tapBtnReaded(_ sender: Any) {
        viewParentTutorial.removeFromSuperview()
    }
}
