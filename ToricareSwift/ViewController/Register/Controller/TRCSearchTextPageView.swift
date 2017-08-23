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
        let vc = TRCPharmacySearchResultsViewController(nibName: "TRCPharmacySearchResultsViewController", bundle: nil)

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

        configBackButton()
        
        if(_obj.mode == MODE_MYPAGE){
            _obj.nc5.pushViewController(vc, animated: true)
        }else if(_obj.mode == MODE_REGISTER){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
