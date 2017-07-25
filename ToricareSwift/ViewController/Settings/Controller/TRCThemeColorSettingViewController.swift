//
//  TRCThemeColorSettingViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCThemeColorSettingViewController: TRCBaseViewController {

    @IBOutlet weak var tblTheme: UITableView!
    
    var listTitleColors: [String]?
    var listColors: [String]?
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Config ui
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_SETTING_THEME
        
        //table view
        tblTheme.dataSource = self
        tblTheme.delegate = self
        tblTheme.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        listTitleColors = [Localizable(value: "green"), Localizable(value: "pink"), Localizable(value: "blue"), Localizable(value: "brown")]
        
        listColors = [MAIN_COLOR, MAIN_COLOR_2, MAIN_COLOR_3, MAIN_COLOR_4]
        
        tblTheme.tableFooterView = UIView()

    }
}

extension TRCThemeColorSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = self.listTitleColors?[indexPath.row]
        
        //checkmark state with current color
//        let currentColor = UserDefaults.kGetValue(THEME_COLOR) as! String
//        if(self.listColors?[indexPath.row] == currentColor){
//            cell.accessoryType = .checkmark;
//        }else{
//            cell.accessoryType = .none;
//        }

        return cell
    }
}

extension TRCThemeColorSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tblTheme.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        //save new color instead old color
        let newTheme = self.listColors![indexPath.row]
        UserDefaults.kSetValue(newTheme, THEME_COLOR)
        tblTheme.reloadData()
        
        //set new color for navigation bar
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        Singleton.shared.nc1.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        Singleton.shared.nc2.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        Singleton.shared.nc3.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        Singleton.shared.nc4.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        Singleton.shared.nc5.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        self.navigationController?.navigationBar.barTintColor = UIColor.init(hexString: newTheme)
        self.tabBarController?.tabBar.barTintColor = UIColor.init(hexString: newTheme)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tblTheme.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
