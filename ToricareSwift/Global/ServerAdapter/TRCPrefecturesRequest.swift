//
//  TRCPrefecturesRequest.swift
//  ToricareSwift
//
//  Created by tuan on 8/4/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCPrefecturesRequest: TRCBaseAPIController {
    func getPrefectures(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        self.callAPI(Dictionary <String, String>(), atPath: "\(URL_PREFECTURES)", withMethod: HTTP_GET, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
        
//        TRCBaseAPIController.callAPI(parameters, atPath: "\(URL_LOGIN)", withMethod: HTTP_POST, blockCompletion: { (data) in
//            //parse data from model
//            completion(data)
//        }) { (error) in
//            failed(error!)
//        }
    }

}
