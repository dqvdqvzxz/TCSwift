//
//  TRCHomeViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/26/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCHomeViewController: TRCBaseViewController {
    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewNotification: UIView!
    @IBOutlet weak var lblTitleGroupNotification: UILabel!
    @IBOutlet weak var viewImageNotification1: UIView!
    @IBOutlet weak var lblTitleNotification1: UILabel!
    @IBOutlet weak var viewImageNotification2: UIView!
    @IBOutlet weak var lblTitleNotification2: UILabel!
    @IBOutlet weak var lblMoreNotification: UILabel!
    
    @IBOutlet weak var viewSummary: UIView!
    @IBOutlet weak var lblTitleGroupSummary: UILabel!
    @IBOutlet weak var lblStep: UILabel!
    @IBOutlet weak var lblStepUnit: UILabel!
    @IBOutlet weak var viewImageSummary: UIView!
    @IBOutlet weak var viewBorderInformSummary: UIView!
    @IBOutlet weak var lblInformSummary: UILabel!
    
    @IBOutlet weak var viewBorderExerciseKcal: UIView!
    @IBOutlet weak var viewExerciseKcal: UIView!
    @IBOutlet weak var viewBorderTitleExerciseKcal: UIView!
    @IBOutlet weak var viewBorderImageExerciseKcal: UIView!
    @IBOutlet weak var viewImageExerciseKcal: UIView!
    @IBOutlet weak var viewBorderLblTitleExerciseKcal: UIView!
    @IBOutlet weak var lblTitleExerciseKcal: UILabel!
    @IBOutlet weak var viewBorderContentExerciseKcal: UIView!
    @IBOutlet weak var lblContentExerciseKcal: UILabel!
    @IBOutlet weak var lblContentExerciseKcalUnit: UILabel!
    
    @IBOutlet weak var viewBorderFoodKcal: UIView!
    @IBOutlet weak var viewFoodKcal: UIView!
    @IBOutlet weak var viewBorderTitleFoodKcal: UIView!
    @IBOutlet weak var viewBorderImageFoodKcal: UIView!
    @IBOutlet weak var viewImageFoodKcal: UIView!
    @IBOutlet weak var viewBorderLblTitleFoodKcal: UIView!
    @IBOutlet weak var lblTitleFoodKcal: UILabel!
    @IBOutlet weak var viewBorderContentFoodKcal: UIView!
    @IBOutlet weak var lblContentFoodKcal: UILabel!
    @IBOutlet weak var lblContentFoodKcalUnit: UILabel!
    
    @IBOutlet weak var viewWeight: UIView!
    
    @IBOutlet weak var viewBorderBanner1: UIView!
    @IBOutlet weak var viewImageBanner1: UIView!
    @IBOutlet weak var viewBorderBanner2: UIView!
    @IBOutlet weak var viewImageBanner2: UIView!

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
//        testBtn.buttonStyle(title: "Test BTN", fontSize: 7, titleColor: "0caa7d", borderWidth: 1, borderColor: "nil", radius: nil, backgroundColor: nil)
//        
//        testLabel.labelStyle(title: "Test Label", fontSize: 20, textColor: "0caa7d")
//        
//        textTextField.textFieldStyle(placeHolder: "Test Place hoder", fontSize: 15, textColor: "0caa7d", borderWidth: 1, borderColor: "a6d4ca", radius: 5, backgroundColor: "a6d4ca")
//        
//        TRCLoginAPIController().Login("", "", completion: {
//            //xu ly hien thi du lieu khi pass
//            DLog("1")
//            
//        }) { (String) in
//            //khi fail
//            DLog("2")
//        }
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_TAB_HOME

        
        //UI of outlet
    }
    
    //MARK: Action
    func action(){
        //
    }
}
