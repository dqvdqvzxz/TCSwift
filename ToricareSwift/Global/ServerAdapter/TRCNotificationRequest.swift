//
//  TRCNotificationRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/8/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationRequest: TRCBaseAPIController {
    func NotificationInfoChange(_ isPushed: String, _ isReceivedShop: String, _ isReceivedOperator: String, _ isReceivedWeight: String, _ isReceivedBreafast : String, _ isReceivedLunch: String, _ isReceivedDinner: String, isReceivedSnack: String, _ weightTime: String, _ breakfastTime: String, _ lunchTime: String, _ dinnerTime: String, _ snackTime: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["is_pushed"] = isPushed
        parameters["is_received_shop"] = isReceivedShop
        parameters["is_received_operator"] = isReceivedOperator
        parameters["is_received_weight"] = isReceivedWeight
        parameters["is_received_breakfast"] = isReceivedBreafast
        parameters["is_received_lunch"] = isReceivedLunch
        parameters["is_received_dinner"] = isReceivedDinner
        parameters["is_received_snack"] = isReceivedSnack
        parameters["weight_time"] = weightTime
        parameters["breakfast_time"] = breakfastTime
        parameters["lunch_time"] = lunchTime
        parameters["dinner_time"] = dinnerTime
        parameters["snack_time"] = snackTime
        
        DLog(parameters)
        
        self.callAPI(parameters, atPath: "\(URL_NOTIFICATION)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func NotificationInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_NOTIFICATION)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
