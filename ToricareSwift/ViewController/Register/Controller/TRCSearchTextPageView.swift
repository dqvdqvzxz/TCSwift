//
//  TRCSearchTextPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/22/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSearchTextPageView: TRCBaseViewController {

    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var tfSearch: UITextField!
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var mode: String = MODE_REGISTER
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSearch.buttonStyle(title: STRING_SEARCH)
    
        configUI()
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
        if(mode == MODE_REGISTER){
            let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
            vc.mode = MODE_REGISTER
            //data search
            if(self.tfSearch.text != nil){
                UserDefaults.saveUD(self.tfSearch.text, SEARCH_KEYWORD)
            }
            //back button
            backButton()
            _obj.nc5.pushViewController(vc, animated: true)
        }else if(mode == MODE_MYPAGE){
            let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            //data search
            if(self.tfSearch.text != nil){
                UserDefaults.saveUD(self.tfSearch.text, SEARCH_KEYWORD)
            }
            backButton()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
