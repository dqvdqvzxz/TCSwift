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
    
    var refreshControl = UIRefreshControl()
    
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
        self.navigationItem.title = Localizable(value: "message_list")
        
        //table view
        tblMessage.dataSource = self
        tblMessage.delegate = self
        tblMessage.register(UINib(nibName: "TRCMessageListCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblMessage.tableFooterView = UIView()
        
        configRefresh()
    }
    
    func configRefresh(){
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tblMessage.addSubview(refreshControl)
    }
    
    func refresh(sender: AnyObject){
        tblMessage.reloadData()
        refreshControl.endRefreshing()
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
        cell.imgView.image = #imageLiteral(resourceName: "message_new")
        cell.lblTitle.labelStyle(title: "明日10時お待ちしております", fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
        cell.lblSubTitle.labelStyle(title: "明日10時お待ちしております", fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
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
        
        currentCell.imgView.image = #imageLiteral(resourceName: "message_read")
        currentCell.lblTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
        currentCell.lblSubTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
        currentCell.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
        
        let vc = TRCDetailMessageViewController(nibName: "TRCDetailMessageViewController", bundle: nil)
        let backItem = UIBarButtonItem()
        backItem.title = STRING_BACK
        navigationItem.backBarButtonItem = backItem
        _obj.nc1.pushViewController(vc, animated: true)
    }
}
