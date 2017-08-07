//
//  TRCPasswordChangeRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPasswordRequest: TRCBaseAPIController {
    func PasswordChange(_ currentPassword: String, _ newPassword: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[PASSWORD_PARAM_CHANGE_PASSWORD] = currentPassword
        parameters[PASSWORD_PARAM_CHANGE_NEW_PASSWORD] = newPassword
        
        print("Params \(parameters)")
        print("Token \(UserDefaults.getUD(ACCESS_TOKEN))")
        
        self.callAPI(parameters, atPath: "\(URL_PASSWORD_CHANGE)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
