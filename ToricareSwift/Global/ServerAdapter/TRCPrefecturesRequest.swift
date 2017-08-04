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
    }
    
    func getCity(_ city: String, completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        let cityPath = String(format: "%@/%@/%@", URL_PREFECTURES, city, URL_CITIES)
        self.callAPI(Dictionary <String, String>(), atPath: cityPath, withMethod: HTTP_GET, blockCompletion: { (data) in
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
