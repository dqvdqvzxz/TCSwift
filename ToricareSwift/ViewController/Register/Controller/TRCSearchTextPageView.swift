//
//  TRCSearchTextPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

protocol TRCSearchTextPageViewDelegate {
    func pushTextToSearchResult(_ mode: String)
} 

class TRCSearchTextPageView: TRCBaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var delegate: TRCSearchTextPageViewDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSearch.buttonStyle(title: STRING_SEARCH)
    
        configUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        lblTitle.labelStyle(title: Localizable(value: "search_text"))
        
        tfSearch.textFieldStyle(placeHolder: Localizable(value: "search_text_placeholder"))
        tfSearch.addRightImage(#imageLiteral(resourceName: "ic_search"))
    }
    
    @IBAction func tapBtnSearch(_ sender: Any) {
        validate()
    }
    
    func validate() {
        if (tfSearch.text?.isBlank)! {
            self.showAlert(Localizable(value: "please_input_text"))
            return
        }
        doSearch()
    }
    
    func doSearch(){
        //data search
        if(self.tfSearch.text != nil){
            UserDefaults.saveUD(self.tfSearch.text?.trim(), SEARCH_KEYWORD)
        }
        
        UserDefaults.removeUD(SEARCH_PREFECTURE_NAME)
        UserDefaults.removeUD(SEARCH_TOWN_NAME)
        UserDefaults.removeUD(SEARCH_PREFECTURE)
        UserDefaults.removeUD(SEARCH_TOWN)
        UserDefaults.removeUD(SEARCH_LAT)
        UserDefaults.removeUD(SEARCH_LON)
        
        if(_obj.mode == MODE_MYPAGE){
            if (delegate != nil) {
                delegate.pushTextToSearchResult(MODE_MYPAGE)
                return
            }
        }else if(_obj.mode == MODE_REGISTER){
            if (delegate != nil) {
                delegate.pushTextToSearchResult(MODE_REGISTER)
                return
            }
        }
    }
}
