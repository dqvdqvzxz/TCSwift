//
//  TRCMessageRequest.swift
//  ToricareSwift
//
//  Created by tuan on 8/14/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCMessageRequest: TRCBaseAPIController {
    func getMessage(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_MEMBERS_MESSAGES)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
    
    func readMessage(_ messageId: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_MEMBERS_MESSAGES)" + "/read/" + messageId, withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
