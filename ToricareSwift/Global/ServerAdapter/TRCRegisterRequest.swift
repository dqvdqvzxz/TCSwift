//
//  TRCRegisterAPIController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCRegisterRequest: TRCBaseAPIController {
    func Register(_ mailAddress: String, _ password: String, _ firstName: String, _ lastName: String, _ firstNameKata: String, _ lastNameKata: String, _ genderType: String, _ birthDay: String, _ registerType: String,completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters["email"] = mailAddress
        parameters["password"] = password
        parameters["first_name"] = firstName
        parameters["last_name"] = lastName
        parameters["first_name_kana"] = firstNameKata
        parameters["last_name_kana"] = lastNameKata
        parameters["gender_type"] = genderType
        parameters["birthday"] = birthDay
        parameters["device_id"] = UserDefaults.getUD(DEVICE_ID) as? String
        parameters["device_type"] = DEVICE_TYPE
        parameters["device_token"] = "1501748135775"
        parameters["register_type"] = registerType
        parameters["facebook_id"] = _obj.dicFacebookInfo[FB_USERID]
        parameters["facebook_token"] = UserDefaults.getUD(FB_TOKEN) as? String
        
        print(parameters)
        
        self.callAPI(parameters, atPath: "\(URL_REGISTER)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
        
    }
}
