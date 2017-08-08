//
//  TRCMyPharmacistInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMyPharmacistInputViewController: TRCBaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lblInform: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblNote: UILabel!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tvNote: UITextView!
    
    @IBOutlet weak var btnPharmacistInput: UIButton!
    
    var mode = String()
    
    var dataResult = NSDictionary()
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = Localizable(value: "my_pharmacist_setting")
        
        if(mode == MODE_REGISTER){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: Localizable(value: "skip"), style: .plain, target: self, action: #selector(skipAction))
            
            lblInform.labelStyle(title: Localizable(value: "please_register_your_pharmacist"))
        }else if(mode == MODE_MYPAGE){
            lblInform.labelStyle()
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            
            let attrs1 = [NSForegroundColorAttributeName : UIColor.init(hexString: LABEL_FONT_COLOR)]
            let attrs2 = [NSForegroundColorAttributeName : UIColor.init(hexString: LABEL_FONT_GREY_COLOR)]
            
            let attributedString1 = NSMutableAttributedString(string:"薬局 \nサンドラッグ赤堤薬局 ", attributes:attrs1)
            let attributedString2 = NSMutableAttributedString(string:"\n※変更できません。", attributes:attrs2)
            
            attributedString1.append(attributedString2)
            attributedString1.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString1.length))
            
            lblInform.attributedText = attributedString1
            
            if(dataResult != nil){
                tfName.textFieldStyle(placeHolder: dataResult.object(forKey: "name") as? String)
                tfPhone.textFieldStyle(placeHolder: dataResult.object(forKey: "tel") as? String)
                tfEmail.textFieldStyle(placeHolder: dataResult.object(forKey: "email") as? String)
                tvNote.text = dataResult.object(forKey: "note") as? String
            }
        }
        
        lblInform.lineBreakMode = .byWordWrapping
        lblInform.numberOfLines = 0
    
        
        //UI of outlet
        btnPharmacistInput.buttonStyle(title: Localizable(value: "register_my_pharmacist"))
        
        lblName.labelStyle(title: Localizable(value: "pharmacist_name"))
        lblPhone.labelStyle(title: Localizable(value: "pharmacist_phone"))
        lblEmail.labelStyle(title: Localizable(value: "pharmacist_mail_address"))
        lblNote.labelStyle(title: Localizable(value: "pharmacist_note"))

    }
    
    //MARK: Action
    func skipAction(){
        let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
        vc.mode = MODE_SKIP
        let navController = UINavigationController(rootViewController: vc)
        UIApplication.shared.keyWindow?.rootViewController = navController
    }
    
    //MARK: Button Action
    @IBAction func tapBtnPharmacistInput(_ sender: Any) {
        if(mode == MODE_REGISTER){
            TRCPharmacistRequest().PharmacistInfoCreate(tfName.text!, tfPhone.text!, tfEmail.text!, tvNote.text!,completion: {(data) in
                self.hideHUD()
                let vc = TRCUserRegistCompleteViewController(nibName: "TRCUserRegistCompleteViewController", bundle: nil)
                vc.mode = MODE_REGISTER
                let backItem = UIBarButtonItem()
                backItem.title = STRING_BACK
                self.navigationItem.backBarButtonItem = backItem
                self.navigationController?.pushViewController(vc, animated: true)
            }) { (error) in
                self.hideHUD()
                self.showAlert(error)
            }

        }else if(mode == MODE_MYPAGE){
            if(dataResult != nil){
                TRCPharmacistRequest().PharmacistInfoChange(tfName.text!, tfPhone.text!, tfEmail.text!, tvNote.text!,completion: {(data) in
                    self.hideHUD()
                    
                    let viewControllers: [UIViewController] = _obj.nc5.viewControllers
                    for descView in viewControllers {
                        if(descView is TRCMyPageViewController){
                            _obj.nc5.popToViewController(descView, animated: true)
                        }
                    }
                }) { (error) in
                    self.hideHUD()
                    ELog(error)
                    self.showAlert(error)
                }
            }
            TRCPharmacistRequest().PharmacistInfoCreate(tfName.text!, tfPhone.text!, tfEmail.text!, tvNote.text!,completion: {(data) in
                self.hideHUD()
                
                let viewControllers: [UIViewController] = _obj.nc5.viewControllers
                for descView in viewControllers {
                    if(descView is TRCMyPageViewController){
                        _obj.nc5.popToViewController(descView, animated: true)
                    }
                }
            }) { (error) in
                self.hideHUD()
                ELog(error)
                self.showAlert(error)
            }
            
            
//            let alert = UIAlertController(title: nil,
//                                          message: "プロフィールを更新しました",
//                                          preferredStyle: .alert)
//            // add the action
//            alert.addAction(UIAlertAction(title: Localizable(value: "OK"),
//                                          style: UIAlertActionStyle.default,
//                                          handler: { action in
//                                            let viewControllers: [UIViewController] = _obj.nc5.viewControllers
//                                            for descView in viewControllers {
//                                                if(descView is TRCMyPageViewController){
//                                                    _obj.nc5.popToViewController(descView, animated: true)
//                                                }
//                                            }
//            }))
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
        }
    }
}
