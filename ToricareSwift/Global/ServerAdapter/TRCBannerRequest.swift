//
//  TRCBannerRequest.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 8/24/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

class TRCBannerRequest: TRCBaseAPIController {
    func getBanner(completion: @escaping(_ result: NSDictionary?)->(), failed: @escaping(_ error: String)->()){
        
        let parameters = Dictionary <String, String>()
        
        self.callAPI(parameters, atPath: "\(URL_BANNERS)", withMethod: HTTP_GET, blockCompletion: { (data) in
            //parse data from model
            
            let dataResult = data?.object(forKey: DATA) as! NSDictionary
            
            guard let dataListBanner = dataResult.object(forKey: "listBanners") else { return }
            
//            
//            
//            
//            for listImage in dataListBanner{
//                let imagePath = listImage["image_path"]
//                
//                
//            }
            
            print("Call me \(dataListBanner)")
            
            completion(data)
        }) { (error) in
            failed(error!)
        }
    }
}
