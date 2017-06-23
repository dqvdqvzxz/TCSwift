//
//  TRCLoginController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCLoginController: NSObject {
    func Login(_ mailAddress: String, _ password: String, completion: @escaping()->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["mail_address"] = mailAddress
        parameters["password"] = password
        parameters["device_id"] = ""
        parameters["device_token"] = ""
        parameters["device_type"] = ""
        
        sendParams(parameters, atPath: "\(URL_LOGIN)", blockCompletion: { (data) in
            completion()
        }) { (error) in
            failed(error!)
        }

    }
}
