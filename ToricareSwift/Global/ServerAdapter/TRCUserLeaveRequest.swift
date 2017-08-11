//
//  TRCUserLeaveRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/11/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCUserLeaveRequest: TRCBaseAPIController {
    func deleteAccount(_ accessToken: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[ACCESS_TOKEN] = accessToken
        
        self.callAPI(parameters, atPath: "\(URL_REGISTER)", withMethod: HTTP_DELETE, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }

}
