//
//  TRCEmailRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/7/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCEmailRequest: TRCBaseAPIController {
    func EmailChange(_ newEmail: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        var parameters = Dictionary <String, String>()
        parameters[EMAIL_PARAM_CHANGE] = newEmail
        
        self.callAPI(parameters, atPath: "\(URL_EMAIL_CHANGE)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
