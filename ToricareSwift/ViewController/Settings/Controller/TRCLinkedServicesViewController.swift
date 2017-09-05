//
//  TRCLinkedServicesViewController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 7/5/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit
import HealthKit

class TRCLinkedServicesViewController: TRCBaseViewController {

    @IBOutlet weak var tblLinked: UITableView!
    
    //declare for HealthKit
    let healthManager: HealthKitManager = HealthKitManager()

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
        self.navigationItem.title = STRING_SETTING_OTHER_SERIVCES
        
        //table view
        tblLinked.dataSource = self
        tblLinked.delegate = self
        tblLinked.register(UINib(nibName: "TRCLinkedServiceCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tblLinked.tableFooterView = UIView()
    }
    
    //MARK: Setup healthkit
    func getHealthKitPermission(){
        healthManager.authorizeHealthKit { (authorized, error) in
            if authorized{
                //get and set the user's step count
            }else{
                if error != nil{
                    ELog(error)
                }
                ELog("Permission denied.")
            }
        }
    }
    
    //Retriever step count 
    func retrieveStepCount(completion: (_ stepRetrieved: Double) -> Void){
        //define the step quantity type
        let stepCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
        
        //get the start of the day
        let date = Date()
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let newDate = cal.startOfDay(for: date)
        
        //set the predicates & interval
//        let predicate = HKQuery.prediacty
    }
}

extension TRCLinkedServicesViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0:
            return 1
        case 1:
            return 1
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return Localizable(value: "health_manager_feature")
        case 1:
            return Localizable(value: "service_other")
        default:
            break
        }
        return ""
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
//        
//        switch (section) {
//        case 0:
//            headerLabel.labelStyle(title: Localizable(value: "health_manager_feature"))
//            break
//        case 1:
//            headerLabel.labelStyle(title: Localizable(value: "service_other"))
//            break
//        default:
//            break
//        }
//        headerLabel.backgroundColor = UIColor.init(hexString: GREY_BACKGROUND_COLOR)
//        return headerLabel
//    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TRCLinkedServiceCell
        
        if (indexPath.section == 0) {
            cell.lblTitle.labelStyle(title: Localizable(value: "service_health_care"))
        } else if (indexPath.section == 1) {
            cell.lblTitle.labelStyle(title: Localizable(value: "service_facebook"))
        }
        
        cell.lblTime.isHidden = true
        
        return cell
    }
}

extension TRCLinkedServicesViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            print("Call function setup HealthKit")
            getHealthKitPermission()
        }
    }
}
