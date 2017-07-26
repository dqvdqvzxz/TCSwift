//
//  TRCPasscodeLockSettingViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasscodeLockSettingViewController: TRCBaseViewController {

    @IBOutlet weak var tblPasscode: UITableView!
    
    @IBOutlet weak var btnPasscode: UIButton!
    
    //View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configUI()
        tblPasscode.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = STRING_SETTING_PASSCODE
        
        //UI
        if(UserDefaults.kGetValue(PASSCODE) != nil){
            btnPasscode.isEnabled = true
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"))
        }else{
            btnPasscode.isEnabled = false
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        }
        
        //table view
        tblPasscode.dataSource = self
        tblPasscode.delegate = self
        tblPasscode.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblPasscode.tableFooterView = UIView()
        tblPasscode.isScrollEnabled = false
    }
    
    //MARK: Button Action
    @IBAction func tapBtnPasscode(_ sender: Any) {
        let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
        vc.mode = MODE_CHANGE
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TRCPasscodeLockSettingViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCLinkedServiceCell
        
        cell.lblTitle.text = Localizable(value: "enable_passcode")
        cell.lblTime.isHidden = true
        if(UserDefaults.kGetValue(PASSCODE) != nil){
            cell.switchCell.isOn = true
        }else{
            cell.switchCell.isOn = false
        }
        cell.switchCell.addTarget(self, action: #selector(stateChanged(switchState:)), for: .valueChanged)
        
        return cell
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            btnPasscode.isEnabled = true
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"))
        } else {
            btnPasscode.isEnabled = false
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
        }
    }
}

extension TRCPasscodeLockSettingViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! TRCLinkedServiceCell
        
        currentCell.switchCell.isOn = !currentCell.switchCell.isOn
        
        if(currentCell.switchCell.isOn){
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"))
            btnPasscode.isEnabled = true
            
            let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
            vc.mode = MODE_SETUP
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            btnPasscode.isEnabled = false
            btnPasscode.buttonStyle(title: Localizable(value: "change_passcode"), fontSize: BUTTON_FONT_SIZE, titleColor: BUTTON_TITLE_COLOR, borderWidth: BUTTON_BORDER_WIDTH, borderColor: BUTTON_BORDER_COLOR, radius: BUTTON_RADIUS, backgroundColor: BACKGROUND_COLOR)
            
            let vc = TRCPasscodeLockInputViewController(nibName: "TRCPasscodeLockInputViewController", bundle: nil)
            vc.mode = MODE_REMOVE
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
