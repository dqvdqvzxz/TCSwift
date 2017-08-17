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
    
    @IBOutlet weak var btnMore: UIButton!
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
    @IBOutlet weak var viewBorderImage: UIView!
    @IBOutlet weak var viewBorderTitle: UIView!
    @IBOutlet weak var imgViewWeight: UIImageView!
    @IBOutlet weak var lblRegisterTodayWeight: UILabel!
    @IBOutlet weak var imgViewAccessory: UIImageView!
    
    @IBOutlet weak var viewBorderBanner1: UIView!
    @IBOutlet weak var viewImageBanner1: UIView!
    @IBOutlet weak var viewBorderBanner2: UIView!
    @IBOutlet weak var viewImageBanner2: UIView!
    
    var goalInfo: TRCGoal!
    
    var summaryInfo: TRCSummary!
    
    var accountInfo: TRCAccountInfo!
    
    @IBOutlet var customLeftTab: UIView!
    @IBOutlet weak var lblUnread: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    
    var isRequestUnread = false
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _obj.tabController.tabBar.isHidden = false
        updateUnread("0")
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = false
        getUnreadMessage()
        
        if(_obj.objectGoal != nil){
            self.lblStep.labelStyle(title: _obj.objectGoal.steps, fontSize: LABEL_FONT_SIZE! + 20, isBold: true, textColor: LABEL_FONT_COLOR)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
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
        btnMessage.addTarget(self, action: #selector(pushToMessageList), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem(customView: customLeftTab)
        navigationItem.leftBarButtonItem = leftBarButton
        
        let rightButton =  UIButton()
        rightButton.setImage(UIImage(named: "ic_calendar"), for: .normal)
        rightButton.addTarget(self, action: #selector(action), for: .touchUpInside)
        rightButton.frame = CGRect(x: 7, y: 10, width: 30, height: 30)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButton
        
        //UI of outlet
        lblTitleGroupNotification.labelStyle(title: Localizable(value:  "notify_from_tricare_pharmacy"), fontSize: LABEL_FONT_SIZE! + 2, isBold: true, textColor: LABEL_FONT_COLOR)
        lblTitleNotification1.labelStyle(title: "6/25(日) 第７回ウォークラリー開催")
        lblTitleNotification2.labelStyle(title: "6/07(水) 毎月第一水曜日健康フェア開催")
        btnMore.titleLabel?.text = Localizable(value: "view_more")
//        btnMore.buttonStyle(title: Localizable(value: "view_more"), fontSize: BUTTON_FONT_SIZE! - 2, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: MAIN_COLOR)
        
        //
        lblTitleGroupSummary.labelStyle(title: Localizable(value: "today_step"), fontSize: LABEL_FONT_SIZE! + 2, isBold: false, textColor: LABEL_FONT_COLOR)
        lblStep.labelStyle(title: "-", fontSize: LABEL_FONT_SIZE! + 20, isBold: true, textColor: LABEL_FONT_COLOR)

        lblStepUnit.labelStyle(title: Localizable(value: "walking"), fontSize: LABEL_FONT_SIZE! - 2, isBold: false, textColor: LABEL_FONT_COLOR)
        lblInformSummary.labelStyle(title: Localizable(value: "sucess_percent"), fontSize: LABEL_FONT_SIZE! + 5, isBold: false, textColor: LABEL_FONT_COLOR)
        
        //
        lblTitleExerciseKcal.labelStyle(title: Localizable(value: "exercise"), fontSize: LABEL_FONT_SIZE! + 2, isBold: false, textColor: LABEL_FONT_COLOR)
        lblContentExerciseKcal.labelStyle(title: "720", fontSize: LABEL_FONT_SIZE! + 10, isBold: false, textColor: LABEL_FONT_COLOR)
        lblContentExerciseKcalUnit.labelStyle(title: "Kcal")
        
        lblTitleFoodKcal.labelStyle(title: Localizable(value: "meal"), fontSize: LABEL_FONT_SIZE! + 2, isBold: false, textColor: LABEL_FONT_COLOR)
        lblContentFoodKcal.labelStyle(title: "720", fontSize: LABEL_FONT_SIZE! + 10, isBold: false, textColor: LABEL_FONT_COLOR)
        lblContentFoodKcalUnit.labelStyle(title: "Kcal")
        
        //
        lblRegisterTodayWeight.labelStyle(title: Localizable(value: "register_today_weight"))
        imgViewAccessory.image = #imageLiteral(resourceName: "ic_next")
    }
    
    func updateUnread(_ value: String) {
        if (Int(value)! == 0) {
            lblUnread.text = ""
            lblUnread.isHidden = true
        } else if (Int(value)! < 10 ) {
            lblUnread.isHidden = false
            lblUnread.text = value
            lblUnread.makeCircle()
        } else {
            lblUnread.isHidden = false
            lblUnread.text = "9+"
            lblUnread.makeRoundRect()
        }
    }
    
    //MARK: Get data()
    func getData(){
        self.showHUD()
        //get summary
        TRCSummaryRequest().summaryInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            do {
                self.summaryInfo = try parseDict(dataResult as! JSONObject) as TRCSummary
                _obj.objectSummary = self.summaryInfo
                
                self.hideHUD()
            } catch {
                print("JSONParsin Error: \(error)")
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
        
        //get goal
        TRCGoalRequest().goalInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            do {
                self.goalInfo = try parseDict(dataResult as! JSONObject) as TRCGoal
                _obj.objectGoal = self.goalInfo
                
                self.lblStep.labelStyle(title: String().convertDecimal(_obj.objectGoal.steps), fontSize: LABEL_FONT_SIZE! + 20, isBold: true, textColor: LABEL_FONT_COLOR)
                
                self.hideHUD()
            } catch {
                print("JSONParsin Error: \(error)")
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
        
        //get account info
        TRCAccountInfoRequest().accountInfo(completion: {(data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            do {
                self.accountInfo = try parseDict(dataResult as! JSONObject) as TRCAccountInfo
                _obj.objectAccountInfo = self.accountInfo
                
                self.hideHUD()
            } catch {
                print("JSONParsin Error: \(error)")
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
            ELog(error)
        }
        
        configUI()
    }
    
    func getUnreadMessage() {
        if (isRequestUnread) {
            return
        }
        
        isRequestUnread = true
        TRCMessageRequest().getUnreadMessage(completion: { (data) in
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            let unreadValue = Global().convertObjectToString(dataResult.object(forKey: SUMMARY_UNREAD))
            self.updateUnread(unreadValue)
            self.isRequestUnread = false
        }) { (error) in
            ELog(error)
            self.updateUnread("0")
            self.isRequestUnread = false
        }
    }
    
    //MARK: Action
    func pushToMessageList(){
        let vc = TRCMessageListViewController(nibName: "TRCMessageListViewController", bundle: nil)
        backButton()
//        hideBar()
        _obj.nc1.pushViewController(vc, animated: true)
    }
    
    func action(){
        //
    }
}
