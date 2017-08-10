//
//  TRCTokenRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/10/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCTokenRequest: TRCBaseAPIController {
    func refreshToken(_ accessToken: String, _ refreshToken: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[ACCESS_TOKEN] = accessToken
        parameters[REFRESH_ACCESS_TOKEN] = refreshToken
        
        self.callAPI(parameters, atPath: "\(URL_REFRESH_TOKEN)", withMethod: HTTP_POST, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func deleteToken(_ accessToken: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[ACCESS_TOKEN] = accessToken
        
        self.callAPI(parameters, atPath: "\(URL_LOGIN)", withMethod: HTTP_DELETE, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
