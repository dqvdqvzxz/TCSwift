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

    var loadNumber = 0
    var newFetchBool = 0
    
    //MARK: View controller
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        getData()
//        fetchDataFromServer()
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
//        tblMessage.register(UINib(nibName: "TRCLoadMoreCell", bundle: nil), forCellReuseIdentifier: "LoadMoreCell")
        
        tblMessage.tableFooterView = UIView()
        
        configRefresh()
    }
    
    //MARK: Get data
    func getData() {
        self.showHUD()
        TRCMessageRequest().getMessage(completion: { (data) in
            self.hideHUD()
            guard let data = data else { return }
            guard let messageArray = data.object(forKey: DATA) else { return }
            do {
                self.dataList = try parseArray(messageArray as! [JSONObject])
            }
            catch
            {
                print("JSONParsin Error: \(error)")
            }
        }) { (error) in
            self.hideHUD()
            self.showAlert(error)
        }
    }
    
    
//    func fetchDataFromServer()
//    {
//        loadNumber += 1
//        let urlStr = String(format: "https://jsonplaceholder.typicode.com/posts/\(loadNumber)/comments")
//        let url = URL(string: urlStr)
//        
//        let task = URLSession.shared.dataTask(with: url!) { (data, reponse, error) in
//            if(data != nil)
//            {
//                do
//                {
//                    let jsonData = try JSONSerialization.jsonObject(with: data!, options:.mutableContainers) as! NSMutableArray
//                    for item in jsonData
//                    {
//                        self.dataList.add(item)
//                    }
//                    print(jsonData)
//                    DispatchQueue.main.async(execute: {
//                        self.tblMessage.reloadData()
//                    })
//                }
//                catch{
//                    print("Error in catch block")
//                }
//            }
//            else{
//                
//            }
//        }
//        task.resume()
//    }
    
    //MARK: Action
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if(indexPath.row < dataList.count){
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCMessageListCell
            let messageData = dataList[indexPath.row] as TRCMessage
            //style for cell
        cell.imgView.image = messageData.isRead == "0" ? #imageLiteral(resourceName: "message_new") : #imageLiteral(resourceName: "message_read")
        cell.lblTitle.labelStyle(title: messageData.title, fontSize: LABEL_FONT_SIZE, isBold: true, textColor: LABEL_FONT_COLOR)
        cell.lblSubTitle.labelStyle(title: messageData.sender + " | " + messageData.createdAt, fontSize: LABEL_FONT_SIZE, isBold: false, textColor: LABEL_FONT_GREY_COLOR)
        
        return cell
//        }else{
//            //load more cell
//            let loadMoreCell = tableView.dequeueReusableCell(withIdentifier: "LoadMoreCell") as! TRCLoadMoreCell
//    
//            loadMoreCell.startStopLoading(false)
//            
//            return loadMoreCell
//        }
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        newFetchBool = 0
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        newFetchBool += 1
//        print("Call me \(newFetchBool)")
//    }
}

extension TRCMessageListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if(indexPath.row < dataList.count){
            return 66
//        }else{
//            return 44
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        
//        if(indexPath!.row < dataList.count){
            let currentCell = tableView.cellForRow(at: indexPath!) as! TRCMessageListCell
            
            currentCell.imgView.image = #imageLiteral(resourceName: "message_read")
            currentCell.lblTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
            currentCell.lblSubTitle.textColor = UIColor.init(hexString: BACKGROUND_COLOR)
            currentCell.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
            
            let vc = TRCDetailMessageViewController(nibName: "TRCDetailMessageViewController", bundle: nil)
            let backItem = UIBarButtonItem()
            backItem.title = STRING_BACK
            navigationItem.backBarButtonItem = backItem
            vc.messageData = dataList[(indexPath?.row)!]
            self.navigationController?.pushViewController(vc, animated: true)
//        }else{
//            let loadMoreCell = tableView.cellForRow(at: indexPath!) as! TRCLoadMoreCell
//            loadMoreCell.isUserInteractionEnabled = false
//        }
    }
}

//extension TRCMessageListViewController: UIScrollViewDelegate{
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("Scroll \(newFetchBool)")
//        if(decelerate && newFetchBool >= 2 && scrollView.contentOffset.y >= 0){
//            let tv =  scrollView as! UITableView
//            let lastCellIndexPath = IndexPath(row:dataList.count , section: 0)
//            let refreshCell = tv.cellForRow(at: lastCellIndexPath) as! TRCLoadMoreCell
//            refreshCell.startStopLoading(true)
//            self.fetchDataFromServer()
//            newFetchBool = 0
//        }else if(!decelerate){
//            newFetchBool = 0
//        }
//    }
//}
