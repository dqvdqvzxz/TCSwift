//
//  TRCBannerPageView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/30/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCBannerPageView: TRCBaseViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    var pageIndex: Int = 0
    var imgString: String!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imgView.af_setImage(withURL: URL(string: imgString)!)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(tapGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        UIApplication.shared.openURL(URL(string: urlString)!)
    }
}
