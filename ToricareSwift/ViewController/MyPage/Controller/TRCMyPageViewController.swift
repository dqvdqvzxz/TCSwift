//
//  TRCMyPageViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPageViewController: TRCBaseViewController {

    @IBOutlet weak var viewInfo: UIView!
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPharmacist: UILabel!
    
    @IBOutlet weak var clvMyPage: UICollectionView!
    
    var accountInfo: TRCAccountInfo!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        
//        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.nc5.setNavigationBarHidden(true, animated: animated)
        
        _obj.tabController.tabBar.isHidden = false
        
        
        let selectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: WHITE_COLOR)]
        let unSelectedItem = [NSForegroundColorAttributeName: UIColor.init(hexString: "00532e")]
        
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[0].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[1].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[2].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[3].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(unSelectedItem, for: .normal)
        _obj.tabController.tabBar.items?[4].setTitleTextAttributes(selectedItem, for: .selected)
        
        _obj.tabController.tabBar.items?[0].image = #imageLiteral(resourceName: "home")
        _obj.tabController.tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "home_hl")
        
        _obj.tabController.tabBar.items?[1].image = #imageLiteral(resourceName: "nutrition")
        _obj.tabController.tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "nutrition_hl")
        
        _obj.tabController.tabBar.items?[2].image = #imageLiteral(resourceName: "run")
        _obj.tabController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "run_hl")
        
        _obj.tabController.tabBar.items?[3].image = #imageLiteral(resourceName: "pill")
        _obj.tabController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "pill_hl")
        
        _obj.tabController.tabBar.items?[4].image = #imageLiteral(resourceName: "profile")
        _obj.tabController.tabBar.items?[4].selectedImage = #imageLiteral(resourceName: "profile_hl")
        
        
        _obj.tabController.tabBar.selectionIndicatorImage = UIImage().makeImageWithColorAndSize(color: UIColor.init(hexString: "00532e"), size: CGSize(width: _obj.tabController.tabBar.frame.width/5, height: _obj.tabController.tabBar.frame.height))
        
        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //UI of outlet
        viewInfo.viewStyle(borderWidth: nil, borderColor: nil, radius: nil, backgroundColor: MAIN_COLOR)
        
        lblName.labelStyle(title: "", fontSize: LABEL_FONT_SIZE, isBold: true, textColor: WHITE_COLOR)
        lblPharmacist.labelStyle(title: "My薬局：未設定", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: WHITE_COLOR)
        if(_obj.objectAccountInfo != nil){
            if(_obj.objectAccountInfo.firstName != "" && _obj.objectAccountInfo.lastName != ""){
                self.lblName.labelStyle(title: "\(_obj.objectAccountInfo.firstName) \(_obj.objectAccountInfo.lastName) さん", fontSize: LABEL_FONT_SIZE, isBold: true, textColor: WHITE_COLOR)
            }
            
            if(_obj.objectAccountInfo.shopName != ""){
                lblPharmacist.labelStyle(title: Localizable(value: "my_pharmacy") + "：\(_obj.objectAccountInfo.shopName)", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: WHITE_COLOR)
            }
        }
        
//        clvMyPage.layer.backgroundColor = UIColor(hexString: BACKGROUND_COLOR).cgColor
        
        //image
        imgUser.image = #imageLiteral(resourceName: "default_user")
        if(_obj.objectAccountInfo != nil){
            if(_obj.objectAccountInfo.imagePath.origin != ""){
                imgUser.af_setImage(withURL: URL(string: _obj.objectAccountInfo.imagePath.origin)!, placeholderImage: #imageLiteral(resourceName: "default_user"))
            }
        }

        imgUser.makeBorder(color: UIColor.white)
        imgUser.makeCircle()
        
        //collection view
        clvMyPage.dataSource = self
        clvMyPage.delegate = self
        clvMyPage.register(UINib(nibName: "TRCMyPageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
    
    //MARK: Get data
    func getData(){
        if(_obj.objectAccountInfo == nil){
            self.showHUD()
            TRCAccountInfoRequest().accountInfo(completion: {(data) in
                let dataResult = data?.object(forKey: DATA) as! NSDictionary
                self.hideHUD()
                do {
                    self.accountInfo = try parseDict(dataResult as! JSONObject) as TRCAccountInfo
                    _obj.objectAccountInfo = self.accountInfo
                } catch {
                    print("JSONParsin Error: \(error)")
                }
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
                ELog(error)
            }
        }
    }
    
    func pushToNotificationList(){
        let vc = TRCNotificationPharmacyViewController(nibName: "TRCNotificationPharmacyViewController", bundle: nil)
        vc.notifyFromType = .system
        configBackButton()
        _obj.nc5.pushViewController(vc, animated: true)
    }

}
extension TRCMyPageViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TRCMyPageCell
        
        //style
        cell.backgroundColor = UIColor.init(hexString: COLLECTION_CELL_COLOR)
        
        //item of collection
        switch (indexPath.item) {
        case 0: //account info input
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_profile")
            cell.lblTitle.labelStyle(title: Localizable(value: "profile"))

        case 1: //my pharmacy detail
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_pharmacy")
            cell.lblTitle.labelStyle(title: Localizable(value: "my_pharmacy"))

        case 2: //walking goal detail
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_target")
            cell.lblTitle.labelStyle(title: Localizable(value: "setting_target"))

        case 3: //message
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_message")
            cell.lblTitle.labelStyle(title: Localizable(value: "message"))
            
        case 4:
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_noti")
            cell.lblTitle.labelStyle(title: Localizable(value: "notification"))

        case 5: //settings
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_settings")
            cell.lblTitle.labelStyle(title: STRING_SETTING)
        default:
            break
        }
        
        return cell
    }
}

extension TRCMyPageViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.item) {
        case 0:
            let vc = TRCAccountInfoInputViewController(nibName: "TRCAccountInfoInputViewController", bundle: nil)
            vc.hidesBottomBarWhenPushed = true
            _obj.mode = MODE_MYPAGE
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        case 1:
            let vc = TRCMyPharmacyDetailPageViewController(nibName: "TRCMyPharmacyDetailPageViewController", bundle: nil)
            _obj.mode = MODE_MYPAGE
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        case 2:
            let vc = TRCWalkingGoalDetailViewController(nibName: "TRCWalkingGoalDetailViewController", bundle: nil)
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        case 3:
            let vc = TRCMessageListViewController(nibName: "TRCMessageListViewController", bundle: nil)
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        case 4:
            self.pushToNotificationList()
            break
        case 5:
            let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
            configBackButton()
            _obj.nc5.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension TRCMyPageViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width - 2.4
        let cellWidth = screenWidth / 3.0
        let size = CGSize(width: cellWidth, height: cellWidth)

        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 50)
    }
}
