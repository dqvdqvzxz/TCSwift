//
//  TRCPasscodeLockInputViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasscodeLockInputViewController: UIViewController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblError: UILabel!

    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewImage1: UIView!
    @IBOutlet weak var imgView1: UIImageView!
    @IBOutlet weak var viewImage2: UIView!
    @IBOutlet weak var imgView2: UIImageView!
    
    @IBOutlet weak var viewRight: UIView!
    @IBOutlet weak var viewImage3: UIView!
    @IBOutlet weak var imgView3: UIImageView!
    @IBOutlet weak var viewImage4: UIView!
    @IBOutlet weak var imgView4: UIImageView!
    
    @IBOutlet weak var tfPasscode: UITextField!
    
    var mode = String()
    
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
        self.navigationItem.title = Localizable(value: "change_passcode_title")
        
        //UI
        self.view.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewMain.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewLeft.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage1.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage2.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewRight.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage3.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        viewImage4.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)

        
        imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
        imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        
        tfPasscode.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        tfPasscode.becomeFirstResponder()
    }
    
    //MARK: Action
    func textFieldDidChange(_ textField: UITextField){
        print(tfPasscode.text?.characters.count)
        
        switch (tfPasscode.text?.characters.count as! Int) {
        case 1:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 2:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 3:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        case 4:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_circle")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_circle")
            
            
            }
        default:
            imgView1.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView2.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView3.image = #imageLiteral(resourceName: "ic_passcode_line")
            imgView4.image = #imageLiteral(resourceName: "ic_passcode_line")
        }
    }
}
