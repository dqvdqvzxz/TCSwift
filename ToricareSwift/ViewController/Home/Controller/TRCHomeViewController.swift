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
    @IBOutlet weak var lblInformSummary: UILabel!
    @IBOutlet weak var viewBelowLogo: UIView!
    
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
    @IBOutlet weak var imgLogoCar: UIImageView!
    
    @IBOutlet var customLeftTab: UIView!
    @IBOutlet weak var lblUnread: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    
    @IBOutlet weak var notificationPharmacyView: UIView!
    
    var goalInfo: TRCGoal!
    var summaryInfo: TRCSummary!
    var accountInfo: TRCAccountInfo!
    var bannerArray: [TRCBanner] = []
    var rotationTime = 0
    
    var isRequestUnread = false
    
    var itemIndex: Int = 0
    var timer: Timer!
    @IBOutlet weak var scrollViewBanner: UIScrollView!
    @IBOutlet weak var pageControlBanner: UIPageControl!
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]

    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUnread("0")
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tabbar
        _obj.tabController.tabBar.isHidden = false
        _obj.customizeTabbar(0)
        
        getUnreadMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        configBanner()
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        
        let logoHome = UIImageView(image: #imageLiteral(resourceName: "logo_home"))
        logoHome.frame = CGRect(x: 0, y: 0, width: 137, height: 30)
        logoHome.contentMode = .scaleAspectFit
        self.navigationItem.titleView = logoHome
        
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
        viewMain.backgroundColor = UIColor.init(hexString: HOME_VIEW_MAIN_COLOR)
        notificationPharmacyView.backgroundColor = UIColor.init(hexString: HOME_NOTIFICATION_COLOR)
        viewBelowLogo.backgroundColor = UIColor.init(hexString: HOME_VIEW_BELOW_LOGO_COLOR)
        
        viewNotification.makeRoundRadius()
        notificationPharmacyView.makeRoundRadius()
        viewSummary.makeRoundRadius()
        viewExerciseKcal.makeRoundRadius()
        viewFoodKcal.makeRoundRadius()
        viewWeight.makeRoundRadius()
        viewBelowLogo.makeRoundRadius()
        
        
        lblTitleGroupNotification.labelStyle(title: Localizable(value:  "notify_from_tricare_pharmacy"), fontSize: LABEL_FONT_SIZE!, isBold: true, textColor: WHITE_COLOR)
        lblTitleNotification1.labelStyle(title: "6/25(日) 第７回ウォークラリー開催")
        lblTitleNotification2.labelStyle(title: "6/07(水) 毎月第一水曜日健康フェア開催")
        btnMore.titleLabel?.text = Localizable(value: "view_more")
        btnMore.setTitleColor(UIColor.init(hexString: WHITE_COLOR), for: .normal)
        
        
        //step
        lblTitleGroupSummary.labelStyle(title: Localizable(value: "today_step"), fontSize: LABEL_FONT_SIZE!, isBold: true, textColor: LABEL_FONT_COLOR)
        lblStep.labelStyle(title: "-", fontSize: LABEL_FONT_SIZE! + 25, isBold: true, textColor: HOME_PINK_COLOR)
        lblStepUnit.labelStyle(title: Localizable(value: "walking"), fontSize: LABEL_FONT_SIZE!, isBold: false, textColor: LABEL_FONT_COLOR)
        lblInformSummary.labelStyle(title: "-", fontSize: LABEL_FONT_SIZE!, isBold: true, textColor: LABEL_FONT_COLOR)
        
        //exercise calo
        lblTitleExerciseKcal.labelStyle(title: Localizable(value: "today_exercise"), fontSize: LABEL_FONT_SIZE!, isBold: true, textColor: LABEL_FONT_COLOR)
        lblContentExerciseKcal.labelStyle(title: "-", fontSize: LABEL_FONT_SIZE! + 10, isBold: true, textColor: HOME_PINK_COLOR)
        lblContentExerciseKcalUnit.labelStyle(title: "kcal")
        
        //food calo
        lblTitleFoodKcal.labelStyle(title: Localizable(value: "today_meal"), fontSize: LABEL_FONT_SIZE!, isBold: true, textColor: LABEL_FONT_COLOR)
        lblContentFoodKcal.labelStyle(title: "-", fontSize: LABEL_FONT_SIZE! + 10, isBold: true, textColor: HOME_ORANGE_COLOR)
        lblContentFoodKcalUnit.labelStyle(title: "kcal")
        
        //weight
        lblRegisterTodayWeight.labelStyle(title:  Localizable(value: "register_today_weight"), fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
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
    
    //MARK: Config Banner
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControlBanner.numberOfPages = colors.count
        pageControlBanner.currentPage = 0
        pageControlBanner.tintColor = UIColor.red
        pageControlBanner.pageIndicatorTintColor = UIColor.white
        pageControlBanner.currentPageIndicatorTintColor = UIColor.init(hexString: MAIN_COLOR)
    }
    
    func configBanner() {
        configurePageControl()
        
        scrollViewBanner.delegate = self
        scrollViewBanner.isPagingEnabled = true
        scrollViewBanner.showsHorizontalScrollIndicator = false
        
        var frame: CGRect = CGRect(x:0, y:0, width:0, height:0)
        
        for index in 0..<4 {
            
            frame.origin.x = scrollViewBanner.frame.size.width * CGFloat(index)
            frame.size = scrollViewBanner.frame.size
            
            let subView = UIView(frame: frame)
            subView.backgroundColor = colors[index]
            self.scrollViewBanner.addSubview(subView)
        }
        
        self.scrollViewBanner.contentSize = CGSize(width:self.scrollViewBanner.frame.size.width * 4,height: self.scrollViewBanner.frame.size.height - 10)
        pageControlBanner.addTarget(self, action: #selector(changePage(sender:)), for: .valueChanged)
        
        // Comment it out
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func autoScroll() {
        if (pageControlBanner.currentPage < 4) {
            pageControlBanner.currentPage = pageControlBanner.currentPage + 1
            let nextPos:CGFloat = self.scrollViewBanner.frame.size.width * (CGFloat)(pageControlBanner.currentPage)
            let rect = CGRect(x: nextPos, y: self.scrollViewBanner.frame.origin.y, width: 1.0, height: 1.0)
            scrollViewBanner.scrollRectToVisible(rect, animated: true)
        }
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControlBanner.currentPage) * scrollViewBanner.frame.size.width
        scrollViewBanner.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }

    
    //MARK: Get data()
    func getData(){
        if Connectivity.isConnectToNetwork() == false{
            self.showAlert(STRING_CHECK_NETWORK)
        }else{
            self.showHUD()
            //get summary
            TRCSummaryRequest().summaryInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                do {
                    self.summaryInfo = try parseDict(dataResult as! JSONObject) as TRCSummary
                    _obj.objectSummary = self.summaryInfo
                    
                    if(Int(_obj.objectSummary.stepPercent)! <= 49){
                        self.lblInformSummary.text = "まだ"+(_obj.objectSummary.stepPercent)+"％！がんばろう！"
                        self.imgLogoCar.image = #imageLiteral(resourceName: "character03")
                    }else if(Int(_obj.objectSummary.stepPercent)! >= 50 && Int(_obj.objectSummary.stepPercent)! <= 74){
                        self.lblInformSummary.text = ""+(_obj.objectSummary.stepPercent)+"％達成！まだまだ！"
                        self.imgLogoCar.image = #imageLiteral(resourceName: "character01")
                    }else if(Int(_obj.objectSummary.stepPercent)! >= 75 && Int(_obj.objectSummary.stepPercent)! <= 99){
                        self.lblInformSummary.text = ""+(_obj.objectSummary.stepPercent)+"％達成！あと少し！"
                        self.imgLogoCar.image = #imageLiteral(resourceName: "character02")
                    }else if(Int(_obj.objectSummary.stepPercent)! == 100){
                        self.lblInformSummary.text = "100％達成！おめでとう！！"
                        self.imgLogoCar.image = #imageLiteral(resourceName: "character02")
                    }
                    
                    self.lblContentExerciseKcal.text = String().convertDecimal(_obj.objectSummary.consumptCalo)
                    self.lblContentFoodKcal.text = String().convertDecimal(_obj.objectSummary.intakeCalo)
                    self.lblStep.text = String().convertDecimal(_obj.objectSummary.step)
                    
                    self.hideHUD()
                } catch {
                    DLog("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
//                self.showAlert(error)
                ELog(error)
            }
            
            //get goal
            TRCGoalRequest().goalInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                do {
                    self.goalInfo = try parseDict(dataResult as! JSONObject) as TRCGoal
                    _obj.objectGoal = self.goalInfo
                    
                    self.hideHUD()
                } catch {
                    DLog("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
//                self.showAlert(error)
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
                    DLog("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
                ELog(error)
            }
            
            //get banner
            TRCBannerRequest().getBanner(completion: { (data) in
                self.hideHUD()

                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                let dataListBanner = dataResult.object(forKey: LIST_BANNER)
                self.rotationTime = dataResult.object(forKey: ROTATION) as! Int

                do {
                    let dataResults:[TRCBanner] = try parseArray(dataListBanner as! [JSONObject])
                    dataResults.forEach({ (item) in
                        self.bannerArray.append(item)
                    })
                    
                } catch {
                    DLog("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
                ELog(error)
            }
            
            self.configUI()
        }
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
        configBackButton()
//        hideBar()
        _obj.nc1.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnLoadMoreDidTap(_ sender: Any) {
        pushToNotificationList()
    }
    
    func pushToNotificationList(){
        let vc = TRCNotificationPharmacyViewController(nibName: "TRCNotificationPharmacyViewController", bundle: nil)
        vc.notifyFromType = .pharmacy
        configBackButton()
        //        hideBar()
        _obj.nc1.pushViewController(vc, animated: true)
    }
    
    func action(){
        //
    }
}

extension TRCHomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControlBanner.currentPage = Int(pageNumber)
    }
}
