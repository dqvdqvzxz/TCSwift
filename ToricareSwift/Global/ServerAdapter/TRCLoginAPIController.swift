//
//  TRCLoginController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit


class TRCLoginAPIController: NSObject {
    func Login(_ mailAddress: String, _ password: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["email"] = "minhthaind@gmail.com" //mailAddress
        parameters["password"] = "12345678" //password
        parameters["device_id"] = UserDefaults.kGetValue(DEVICE_ID) as? String
        parameters["device_token"] = "232321423423414514141414143423dfdfdfdfderererere232323232"
        parameters["device_type"] = DEVICE_TYPE
        
        TRCBaseAPIController.callAPI(parameters, atPath: "\(URL_LOGIN)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
