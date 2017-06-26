//
//  TRCLoginController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit


class TRCLoginAPIController: NSObject {
    func Login(_ mailAddress: String, _ password: String, completion: @escaping()->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["mail_address"] = "minhthaind@gmail.com"
        parameters["password"] = "123456"
        parameters["device_id"] = "21323232323232fdfdfdfdddd1111"
        parameters["device_token"] = "232321423423414514141414143423dfdfdfdfderererere232323232"
        parameters["device_type"] = "1"
        
        TRCBaseAPIController.postAPI(parameters, atPath: "\(URL_LOGIN)", blockCompletion: { (data) in
            DLog("Process success")
            completion()
            
        }) { (error) in
            DLog("Process failed")
            failed(error!)
            
        }
    }
}
