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
    var dataList: [TRCMessage] = []
    {
        didSet
        {
            DispatchQueue.main.async {
                self.tblMessage.reloadData()
            }
        }
    }

    var pageNumber = 0
    
    @IBOutlet weak var lblEmpty: UILabel!
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        getData()
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
        configRefresh()
        
        lblEmpty.labelStyle(title: Localizable(value: "empty_data"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblEmpty.isHidden = true

    }
    
    //MARK: Get data
    func getData() {
        if (dataList.count % PAGING_NUMBER == 0) {
            pageNumber += 1
            self.showHUD()
            TRCMessageRequest().getMessage("\(pageNumber)", completion: { (data) in
                self.hideHUD()
                
                guard let data = data else { return }
                guard let messageArray = data.object(forKey: DATA) else { return }
                do {
                    let dataMessageArray:[TRCMessage] = try parseArray(messageArray as! [JSONObject])
                    dataMessageArray.forEach({ (item) in
                        self.dataList.append(item)
                    })
                }
                catch
                {
                    print("JSONParsin Error: \(error)")
                }
                if (self.dataList.count == 0) {
                    self.tblMessage.isHidden = true
                    self.lblEmpty.isHidden = false
                }

            }) { (error) in
                self.pageNumber -= 1
                self.hideHUD()
                if (error == RESULT_NO_DATA && self.pageNumber == 0) {
                    self.tblMessage.isHidden = true
                    self.lblEmpty.isHidden = false
                } else {
                    //                    self.showAlert(error)
                }

            }

        } else {
            return
        }
    }
    
    //MARK: Action
    func configRefresh(){
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: Localizable(value: "pull_to_refresh"))
        refreshControl.tintColor = UIColor.init(hexString: MAIN_COLOR)
        tblMessage.addSubview(refreshControl)
    }
    
    func refresh(sender: AnyObject){
        pageNumber = 0
        dataList.removeAll()
        getData()
        refreshControl.endRefreshing()
    }
}

extension TRCMessageListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCMessageListCell
        let messageData = dataList[indexPath.row] as TRCMessage
        //style for cell
        let isUnread = Int(messageData.isRead) == 0
        cell.imgView.image = messageData.isRead == "0" ? #imageLiteral(resourceName: "message_new") : #imageLiteral(resourceName: "message_read")
        cell.lblTitle.labelStyle(title: messageData.title, fontSize: LABEL_FONT_SIZE, isBold: true, textColor: isUnread ? LABEL_FONT_COLOR : BACKGROUND_COLOR)
        cell.lblSubTitle.labelStyle(title: messageData.sender + " | " + messageData.sentAt, fontSize: LABEL_FONT_SIZE, isBold: false, textColor: isUnread ? LABEL_FONT_GREY_COLOR : BACKGROUND_COLOR)
        
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
        configBackButton()
        vc.messageData = dataList[(indexPath?.row)!]
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = dataList.count - 1
        if indexPath.row == lastElement {
            getData()
        }
    }
}
