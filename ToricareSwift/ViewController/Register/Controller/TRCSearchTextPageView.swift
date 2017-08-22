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

        tfSearch.delegate = self
        if tfSearch.text!.isEmpty{
            btnSearch.isEnabled = false
            btnSearch.buttonStyle(title: STRING_SEARCH, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BACKGROUND_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        }
    
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
        print("Call me")
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

extension TRCSearchTextPageView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (tfSearch.text! as NSString).replacingCharacters(in: range, with: string)
        
        if !text.isEmpty{
            btnSearch.isEnabled = true
            btnSearch.buttonStyle(title: STRING_SEARCH)
        } else {
            btnSearch.isEnabled = false
            btnSearch.buttonStyle(title: STRING_SEARCH, fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BACKGROUND_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        } 
        return true
    }
}
