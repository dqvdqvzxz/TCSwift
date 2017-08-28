//
//  TRCAboutAppViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCAboutAppViewController: TRCBaseViewController {

    @IBOutlet weak var tblAboutApp: UITableView!
    
    //MARK: View Controller
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
        self.navigationItem.title = STRING_SETTING_ABOUT_APP
        
        //table view
        tblAboutApp.dataSource = self
        tblAboutApp.delegate = self
        tblAboutApp.register(UINib(nibName: "TRCAboutAppCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblAboutApp.tableFooterView = UIView()
    }
}

extension TRCAboutAppViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCAboutAppCell
        
        cell.accessoryType = .disclosureIndicator
        
        switch (indexPath.row) {
        case 0:
            cell.lblTitle.labelStyle(title: Localizable(value: "term_of_service"))
            cell.lblVersion.isHidden = true
        case 1:
            cell.lblTitle.labelStyle(title: Localizable(value: "policy"))
            cell.lblVersion.isHidden = true
        case 2:
            cell.lblTitle.labelStyle(title: Localizable(value: "faq"))
            cell.lblVersion.isHidden = true
        case 3:
            cell.lblTitle.labelStyle(title: Localizable(value: "question"))
            cell.lblVersion.isHidden = true
        case 4:
            cell.lblTitle.labelStyle(title: Localizable(value: "app_version"))
            cell.lblVersion.isHidden = false
            cell.lblVersion.text = "1.0.1"
        default:
            break
        }
        
        return cell
    }
}

extension TRCAboutAppViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch (indexPath.row) {
        case 0:
            let vc = TRCWebView(nibName: "TRCWebView", bundle: nil)
            vc.navTitle = Localizable(value: "term_of_service")
            vc.webAddress = APP_TERM
            configBackButton()
            hideBar()
            _obj.nc5.pushViewController(vc, animated: true)
        case 1:
            let vc = TRCWebView(nibName: "TRCWebView", bundle: nil)
            vc.navTitle = Localizable(value: "policy")
            vc.webAddress = APP_POLICY
            configBackButton()
            hideBar()
            _obj.nc5.pushViewController(vc, animated: true)
        case 2:
            let vc = TRCWebView(nibName: "TRCWebView", bundle: nil)
            vc.navTitle = Localizable(value: "faq")
            vc.webAddress = APP_FAQ
            configBackButton()
            hideBar()
            _obj.nc5.pushViewController(vc, animated: true)
        case 3:
            let vc = TRCWebView(nibName: "TRCWebView", bundle: nil)
            vc.navTitle = Localizable(value: "question")
            vc.webAddress = APP_QUESTION
            configBackButton()
            hideBar()
            _obj.nc5.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
