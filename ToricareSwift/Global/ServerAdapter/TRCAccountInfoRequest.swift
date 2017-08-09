//
//  TRCAccountInfoRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCAccountInfoRequest: TRCBaseAPIController {
    func accountInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_ACCOUNT_INFO)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func accountInfoChange(_ firstName: String, _ lastName: String, _ firstNameKata: String, _ lastNameKata: String, _ birthDay: String, _ gender: String,completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[REGISTER_PARAM_FIRST_NAME] = firstName
        parameters[REGISTER_PARAM_LAST_NAME] = lastName
        parameters[REGISTER_PARAM_FIRST_NAME_KATA] = firstNameKata
        parameters[REGISTER_PARAM_LAST_NAME_KATA] = lastNameKata
        parameters[REGISTER_PARAM_BIRTHDAY] = birthDay
        parameters[REGISTER_PARAM_GENDER_TYPE] = gender
        
        print(parameters)
        
        self.callAPI(parameters, atPath: "\(URL_ACCOUNT_INFO)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func uploadAvatar(_ avatarImage: UIImage, completion: @escaping(_ result: String)->(), failed: @escaping(_ error: String)->()){
        self.uploadImage(avatarImage, atPath: URL_MEMBERS_IMAGES, blockCompletion: { (data) in
            guard let data = data else { return }
            if (((data.object(forKey: DATA) as! NSDictionary).object(forKey: MESSAGE)) != nil) {
                completion(RESULT_SUCCESS)
            } else {
                failed(RESULT_FAIL)
            }
            
        }) { (error) in
            failed(error!)
        }
    }
}
