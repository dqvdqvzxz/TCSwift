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
        currentWindow?.frame = self.view.bounds
        currentWindow?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        currentWindow?.addSubview(viewParentTutorial)
//        self.view.addSubview(viewParentTutorial)
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
