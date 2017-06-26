//
//  TRCAPIController.swift
//  ToricareSwift
//
//  Created by Mèo Béo on 6/23/17.
//  Copyright © 2017 Mèo Béo. All rights reserved.
//

import UIKit

import Alamofire

func postAPI(_ params: Dictionary<String, String>, atPath path:String, blockCompletion completion:@escaping (_ data: NSDictionary?) -> (), blockFailed failed:@escaping (_ error:String?)->()){
    
    if Connectivity.isConnectToNetwork() == false{
        Alert(title: kNetworkDisable)
    }else{
        let urls = "\(APP_DOMAIN)\(path)"
        
        let headers = [
            "Authorization" : HEADER_AUTHORIZATION
        ]
        
        if let _ = URL(string: urls){
            Alamofire.request(urls, method: HTTPMethod.post, parameters: params, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (response) in
                
                switch response.result{
                case .success:
                    if let statusCode = response.response?.statusCode{
                        if statusCode == 200{
                            if let json = response.result.value{
                                DLog("JSON: \(json)")
                            }
                        }
                    }
                    DLog("Validation Successfull !")
                case .failure(_):
                    if let statusCode = response.response?.statusCode{
                        ELog("Status code: \(statusCode)")
                        if statusCode == 400{
                            //handle
                        }
                    }
                }
            }
        }
    }
}

