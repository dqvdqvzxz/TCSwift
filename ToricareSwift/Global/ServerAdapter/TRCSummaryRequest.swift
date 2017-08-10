//
//  TRCSummaryRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/10/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCSummaryRequest: TRCBaseAPIController {
    func summaryInfo(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_SUMMARY)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }

}
