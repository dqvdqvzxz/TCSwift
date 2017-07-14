//
//  TRCUserRegistCompleteViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCUserRegistCompleteViewController: TRCBaseViewController {

    @IBOutlet weak var btnQRCode: UIButton!
    @IBOutlet weak var btnUsingApp: UIButton!
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI 
    func configUI(){
        
    }
    
    //MARK: Button Action
    @IBAction func tapBtnQRCode(_ sender: Any) {
    }
    
    @IBAction func tapBtnUsingApp(_ sender: Any) {
        let vc = TRCHomeViewController(nibName: "TRCHomeViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
