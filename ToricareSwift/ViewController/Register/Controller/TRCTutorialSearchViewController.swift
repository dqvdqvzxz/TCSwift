//
//  TRCTutorialSeachViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/21/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCTutorialSearchViewController: UIViewController{

    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnReaded: UIButton!
    
    @IBOutlet weak var viewBorderScrollView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewContent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapBtnCancel(_ sender: Any) {
        
    }

    @IBAction func tapBtnReaded(_ sender: Any) {
    }
}
