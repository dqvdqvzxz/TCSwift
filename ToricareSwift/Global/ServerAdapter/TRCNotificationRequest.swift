//
//  TRCNotificationRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/8/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCNotificationRequest: TRCBaseAPIController {
    func notificationInfoChange(_ isPushed: String, _ isReceivedShop: String, _ isReceivedOperator: String, _ isReceivedWeight: String, _ isReceivedBreafast : String, _ isReceivedLunch: String, _ isReceivedDinner: String, _ isReceivedSnack: String, _ weightTime: String, _ breakfastTime: String, _ lunchTime: String, _ dinnerTime: String, _ snackTime: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[NOTIF_PARAM_PUSHED] = isPushed
        parameters[NOTIF_PARAM_SHOP] = isReceivedShop
        parameters[NOTIF_PARAM_OPERATOR] = isReceivedOperator
        parameters[NOTIF_PARAM_WEIGHT] = isReceivedWeight
        parameters[NOTIF_PARAM_BREAKFAST] = isReceivedBreafast
        parameters[NOTIF_PARAM_LUNCH] = isReceivedLunch
        parameters[NOTIF_PARAM_DINNER] = isReceivedDinner
        parameters[NOTIF_PARAM_SNACK] = isReceivedSnack
        parameters[NOTIF_PARAM_TIME_WEIGHT] = weightTime
        parameters[NOTIF_PARAM_TIME_BREAKFAST] = breakfastTime
        parameters[NOTIF_PARAM_TIME_LUNCH] = lunchTime
        parameters[NOTIF_PARAM_TIME_DINNER] = dinnerTime
        parameters[NOTIF_PARAM_TIME_SNACK] = snackTime
        
        DLog(parameters)
        
        self.callAPI(parameters, atPath: "\(URL_NOTIFICATION)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func notificationInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_NOTIFICATION)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
