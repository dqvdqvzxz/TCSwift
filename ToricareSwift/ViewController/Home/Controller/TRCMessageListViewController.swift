//
//  TRCMessageListViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/24/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMessageListViewController: TRCBaseViewController {

    @IBOutlet weak var tblMessage: UITableView!
    
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
        self.navigationItem.title = ""
        
        //table view
        tblMessage.dataSource = self
        tblMessage.delegate = self
        tblMessage.register(UINib(nibName: "TRCMessageListCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblMessage.tableFooterView = UIView()
    }
}

extension TRCMessageListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCMessageListCell
        
        //style for cell
        cell.imgView.image = UIImage(named: "ic_mail")
        
        return cell
    }
}

extension TRCMessageListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
        let currentCell = tableView.cellForRow(at: indexPath!) as! TRCMessageListCell
        
        currentCell.imgView.image = UIImage(named: "ic_mail_readed")
        currentCell.lblTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
        currentCell.lblSubTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
    }
}