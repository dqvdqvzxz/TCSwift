//
//  TRCWebView.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/25/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCWebView: TRCBaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    
    var webAddress: String?
    
    var navTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = navTitle
        
        webView.delegate = self
        if let url = URL(string: webAddress!) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
