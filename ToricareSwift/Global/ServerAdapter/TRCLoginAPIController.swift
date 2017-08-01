//
//  TRCLoginController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit


class TRCLoginAPIController: NSObject {
    func Login(_ mailAddress: String, _ password: String, completion: @escaping()->(), failed: @escaping()->()){
        
        var parameters = Dictionary <String, String>()
        parameters["mail_address"] = mailAddress
        parameters["password"] = password
        parameters["device_id"] = UserDefaults.kGetValue(DEVICE_ID) as? String
        parameters["device_token"] = "232321423423414514141414143423dfdfdfdfderererere232323232"
        parameters["device_type"] = "1"
        
        TRCBaseAPIController.callAPI(parameters, atPath: "\(URL_LOGIN)", withMethod: HTTP_POST, blockCompletion: { (data) in
            DLog("Process success")
            
            print("Parameter: \(parameters)")
            print(data!)
            
            //parse data from model
            completion()
            
        }) { () in
            print("Parameter: \(parameters)")
            
            failed(ELog("Process failed"))
            
        }
    }
}
