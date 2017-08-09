//
//  TRCRegisterAPIController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/3/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCRegisterRequest: TRCBaseAPIController {
    func register(_ mailAddress: String, _ password: String, _ firstName: String, _ lastName: String, _ firstNameKata: String, _ lastNameKata: String, _ genderType: String, _ birthDay: String, _ registerType: String,completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[REGISTER_PARAM_EMAIL] = mailAddress
        parameters[REGISTER_PARAM_PASSWORD] = password
        parameters[REGISTER_PARAM_FIRST_NAME] = firstName
        parameters[REGISTER_PARAM_LAST_NAME] = lastName
        parameters[REGISTER_PARAM_FIRST_NAME_KATA] = firstNameKata
        parameters[REGISTER_PARAM_LAST_NAME_KATA] = lastNameKata
        parameters[REGISTER_PARAM_GENDER_TYPE] = genderType
        parameters[REGISTER_PARAM_BIRTHDAY] = birthDay
        parameters[REGISTER_PARAM_DEVICE_ID] = UserDefaults.getUD(DEVICE_ID) as? String
        parameters[REGISTER_PARAM_DEVICE_TYPE] = DEVICE_TYPE
        parameters[REGISTER_PARAM_DEVICE_TOKEN] = "1501748135775"
        parameters[REGISTER_PARAM_REGISTER_TYPE] = registerType
        parameters[REGISTER_PARAM_FACEBOOK_ID] = _obj.dicFacebookInfo[FB_USERID]
        parameters[REGISTER_PARAM_FACEBOOK_TOKEN] = UserDefaults.getUD(FB_TOKEN) as? String
        
        self.callAPI(parameters, atPath: "\(URL_REGISTER)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
