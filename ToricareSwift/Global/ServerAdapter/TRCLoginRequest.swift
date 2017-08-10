//
//  TRCLoginController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit


class TRCLoginRequest: TRCBaseAPIController {
    func login(_ mailAddress: String, _ password: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[LOGIN_PARAM_EMAIL] = mailAddress
        parameters[LOGIN_PARAM_PASSWORD] = password
        parameters[LOGIN_PARAM_DEVICE_ID] = UserDefaults.getUD(DEVICE_ID) as? String
        parameters[LOGIN_PARAM_DEVICE_TOKEN] = "232321423423414514141414143423dfdfdfdfderererere232323232"
        parameters[LOGIN_PARAM_DEVICE_TYPE] = DEVICE_TYPE
        
        self.callAPI(parameters, atPath: "\(URL_LOGIN)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func loginFB(_ fbId: String, _ fbToken: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[REGISTER_PARAM_FACEBOOK_ID] = fbId
        parameters[REGISTER_PARAM_FACEBOOK_TOKEN] = fbToken
        parameters[LOGIN_PARAM_DEVICE_ID] = UserDefaults.getUD(DEVICE_ID) as? String
        parameters[LOGIN_PARAM_DEVICE_TOKEN] = "232321423423414514141414143423dfdfdfdfderererere232323232"
        parameters[LOGIN_PARAM_DEVICE_TYPE] = DEVICE_TYPE
        
        self.callAPI(parameters, atPath: "\(URL_LOGIN_FACEBOOK)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
