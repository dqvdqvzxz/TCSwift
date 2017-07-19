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
    @IBOutlet weak var lblTarget: UILabel!
    @IBOutlet weak var lblPharmacist: UILabel!
    
    @IBOutlet weak var clvMyPage: UICollectionView!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _obj.tabController.tabBar.isHidden = false
        
        _obj.nc5.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //UI of outlet
        viewInfo.viewStyle(borderWidth: nil, borderColor: nil, radius: nil, backgroundColor: MAIN_COLOR)
        
        lblName.labelStyle(title: nil)
        lblTarget.labelStyle(title: nil)
        lblPharmacist.labelStyle(title: nil)
        
        clvMyPage.layer.backgroundColor = UIColor(hexString: BACKGROUND_COLOR).cgColor
        
        imgUser.makeCircle()
        
        //collection view
        clvMyPage.dataSource = self
        clvMyPage.delegate = self
        clvMyPage.register(UINib(nibName: "TRCMyPageCell", bundle: nil), forCellWithReuseIdentifier: "Cell")

    }
}
extension TRCMyPageViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! TRCMyPageCell
        
        //style
        cell.backgroundColor = UIColor.init(hexString: COLLECTION_CELL_COLOR)
        
        //item of collection
        switch (indexPath.item) {
        case 0: //account info input
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_profile")
        case 1: //my pharmacy detail
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_pharmacy")
        case 2: //walking goal detail
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_target")
        case 3: //point
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_point")
        case 4: //message
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_message")
        case 5: //set calendar
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_setcalendar")
        case 6: //settings
            cell.imgIcon.image = #imageLiteral(resourceName: "ic_mypage_settings")
            cell.lblTitle.text = STRING_SETTING
        case 7:
            cell.viewImg.isHidden = true
            cell.imgIcon.isHidden = true
            cell.lblTitle.isHidden = true
        case 8:
            cell.viewImg.isHidden = true
            cell.imgIcon.isHidden = true
            cell.lblTitle.isHidden = true
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
            vc.editMode = MODE_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 1:
            let vc = TRCMyPharmacyDetailViewController(nibName: "TRCMyPharmacyDetailViewController", bundle: nil)
            vc.mode = MODE_MYPAGE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 2:
            let vc = TRCWalkingGoalDetailViewController(nibName: "TRCWalkingGoalDetailViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 3:
            let vc = TRCPointViewController(nibName: "TRCPointViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        case 4:
            break
        case 5:
            break
        case 6:
            let vc = TRCSettingViewController(nibName: "TRCSettingViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            _obj.nc5.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

extension TRCMyPageViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width - 2.6
        let cellWidth = screenWidth / 3.0
        let size = CGSize(width: cellWidth, height: cellWidth)

        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 50)
    }
}
