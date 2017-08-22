//
//  TRCQRRequest.swift
//  ToricareSwift
//
//  Created by tuan on 8/21/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCQRRequest: TRCBaseAPIController {
    func sendQR(_ qrString: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        var parameters = Dictionary <String, String>()
        parameters[SHOP_ID] = qrString
        
        self.callAPI(parameters, atPath: "\(URL_MEMBERS_SHOPS_APPROVALS)", withMethod: HTTP_PUT, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
