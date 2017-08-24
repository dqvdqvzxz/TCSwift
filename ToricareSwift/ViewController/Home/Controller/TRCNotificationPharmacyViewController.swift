//
//  TRCNotificationPharmacyViewController.swift
//  ToricareSwift
//
//  Created by tuan on 8/24/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationPharmacyViewController: TRCBaseViewController {
    @IBOutlet weak var tblNotification: UITableView!

    @IBOutlet weak var lblEmpty: UILabel!
    var refreshControl = UIRefreshControl()
    var pageNumber = 0
    var dataList: [TRCNotificationPharmacy] = []
    var notifyFromType: NotificationFromType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Config UI
    func configUI(){
        //navigation
        self.navigationItem.title = notifyFromType == .pharmacy ?
            Localizable(value: "pharmacy_notification") :
            Localizable(value: "manager_notification")
        
        //table view
        tblNotification.dataSource = self
        tblNotification.delegate = self
        tblNotification.register(UINib(nibName: "TRCNotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        configRefresh()
        
        lblEmpty.labelStyle(title: Localizable(value: "empty_data"), fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        lblEmpty.isHidden = true
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    //MARK: Action
    func configRefresh(){
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: Localizable(value: "pull_to_refresh"))
        refreshControl.tintColor = UIColor.init(hexString: MAIN_COLOR)
        tblNotification.addSubview(refreshControl)
    }
    
    func refresh(sender: AnyObject){
        pageNumber = 0
        dataList.removeAll()
        getData()
        refreshControl.endRefreshing()
    }

    //MARK: Get data
    func getData() {
//        if (dataList.count % PAGING_NUMBER == 0) {
//            pageNumber += 1
//            self.showHUD()
//            TRCMessageRequest().getMessage("\(pageNumber)", completion: { (data) in
//                self.hideHUD()
//                
//                guard let data = data else { return }
//                guard let messageArray = data.object(forKey: DATA) else { return }
//                do {
//                    let dataMessageArray:[TRCMessage] = try parseArray(messageArray as! [JSONObject])
//                    dataMessageArray.forEach({ (item) in
//                        self.dataList.append(item)
//                    })
//                }
//                catch
//                {
//                    print("JSONParsin Error: \(error)")
//                }
//                if (self.dataList.count == 0) {
//                    self.tblMessage.isHidden = true
//                    self.lblEmpty.isHidden = false
//                }
//                
//            }) { (error) in
//                self.pageNumber -= 1
//                self.hideHUD()
//                if (error == RESULT_NO_DATA && self.pageNumber == 0) {
//                    self.tblMessage.isHidden = true
//                    self.lblEmpty.isHidden = false
//                } else {
//                    //                    self.showAlert(error)
//                }
//                
//            }
//            
//        } else {
//            return
//        }
    }
}

extension TRCNotificationPharmacyViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20//dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCNotificationTableViewCell
//        let notiData = dataList[indexPath.row] as TRCNotificationPharmacy
        //style for cell
        cell.lblMainTitle.text = "第７回ウォークラリー開催"
        cell.lblSubTitle.text = "2017/12/04 10:00"
        
        return cell
    }
}

extension TRCNotificationPharmacyViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let indexPath = tableView.indexPathForSelectedRow
//        let currentCell = tableView.cellForRow(at: indexPath!) as! TRCMessageListCell
//        currentCell.imgView.image = #imageLiteral(resourceName: "message_read")
//        currentCell.lblTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
//        currentCell.lblSubTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
//        currentCell.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
//        
//        let vc = TRCDetailMessageViewController(nibName: "TRCDetailMessageViewController", bundle: nil)
//        configBackButton()
//        vc.messageData = dataList[(indexPath?.row)!]
//        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let lastElement = dataList.count - 1
//        if indexPath.row == lastElement {
//            getData()
//        }
    }
}

